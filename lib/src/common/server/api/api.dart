import "dart:async";
import "dart:convert";
import "dart:io";

import "package:connectivity_plus/connectivity_plus.dart";
import "package:dio/dio.dart";
import "package:dio/io.dart";
import "package:flutter/foundation.dart";
import "package:flutter/services.dart";
import "package:l/l.dart";
import "package:sfx/src/common/local/app_storage.dart";

import "../interceptors/connectivity_interceptor.dart";
import "api_connection.dart";
import "api_constants.dart";

@immutable
class ApiService {
  factory ApiService() => _service;

  const ApiService._internal();

  static const ApiService _service = ApiService._internal();

  static Future<Dio> initDio() async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        headers: await ApiService.getHeaders(),
        connectTimeout: ApiConst.connectionTimeout,
        receiveTimeout: ApiConst.sendTimeout,
        sendTimeout: ApiConst.sendTimeout,
        validateStatus: (int? status) => status != null && status < 205,
      ),
    );

    dio.interceptors.addAll(
      <Interceptor>[
        ConnectivityInterceptor(
          requestReceiver: Connection(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      ],
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }

  static Future<Dio> initDioWithManualHeaders() async {
    final Dio dio = Dio(
      BaseOptions(
        baseUrl: ApiConst.baseUrl,
        headers: await ApiService.getHeadersWithToken(),
        connectTimeout: ApiConst.connectionTimeout,
        receiveTimeout: ApiConst.sendTimeout,
        sendTimeout: ApiConst.sendTimeout,
        validateStatus: (int? status) => status != null && status < 205,
      ),
    );

    dio.interceptors.addAll(
      <Interceptor>[
        ConnectivityInterceptor(
          requestReceiver: Connection(
            dio: dio,
            connectivity: Connectivity(),
          ),
        ),
      ],
    );

    (dio.httpClientAdapter as DefaultHttpClientAdapter).onHttpClientCreate =
        (HttpClient client) {
      client.badCertificateCallback =
          (X509Certificate cert, String host, int port) => true;
      return client;
    };

    return dio;
  }

  static Future<Map<String, String>> getHeaders() async {
    final Map<String, String> headers = <String, String>{
      "Content-type": "application/json",
    };

    return headers;
  }

  static Future<Map<String, String>> getHeadersWithToken() async {
    Map<String, String> headers = <String, String>{
      "Content-type": "application/json",
    };

    String? accessToken = await AppStorage.$read(key: StorageKey.accessToken);
    if (accessToken != null && accessToken.isNotEmpty) {
      if (isAccessTokenExpired(accessToken)) {
        try {
          await refreshAccessToken();
          accessToken = await AppStorage.$read(key: StorageKey.accessToken);
        } catch (e) {
          l.e("Token refresh failed: $e");
        }
      }
      headers.putIfAbsent("authorization", () => "Bearer $accessToken");
    }

    return headers;
  }

  static Future<String?> get(String api, Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response =
          await (await initDio()).get<dynamic>(api, queryParameters: params);
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (e) {
      l.e(e.toString());
      rethrow;
    }
  }

  static Future<String?> getWithToken(
      String api, Map<String, dynamic> params) async {
    try {
      final Response<dynamic> response =
          await (await initDioWithManualHeaders())
              .get<dynamic>(api, queryParameters: params);
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (e) {
      l.e(e.toString());
      rethrow;
    }
  }

  static Future<String?> post(String api, Map<String, dynamic> data,
      [Map<String, dynamic> params = const <String, dynamic>{}]) async {
    try {
      final Response<dynamic> response =
          await (await initDioWithManualHeaders()).post<dynamic>(
        api,
        data: data,
      );
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> postWithoutManualHeader(
      String api, Map<String, dynamic> data,
      [Map<String, dynamic> params = const <String, dynamic>{}]) async {
    try {
      final Response<dynamic> response = await (await initDio()).post<dynamic>(
        api,
        data: data,
      );
      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> put(String api, Map<String, dynamic> data) async {
    try {
      final Response<dynamic> response =
          await (await initDio()).put<dynamic>(api, data: data);

      return jsonEncode(response.data);
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioError catch (e) {
      l.e(e.response.toString());
      rethrow;
    } on Object catch (_) {
      rethrow;
    }
  }

  static Future<String?> delete(String api) async {
    try {
      final Response response =
          await (await initDioWithManualHeaders()).delete(api);
      l.i("Response status code: ${response.statusCode}");
      l.i("Response data: ${response.data}");

      if (response.statusCode == 200) {
        return "success";
      } else {
        l.e("Error response: ${response.statusCode} ${response.statusMessage}");
        return "error";
      }
    } on TimeoutException catch (_) {
      l.e("The connection has timed out, Please try again!");
      rethrow;
    } on DioException catch (e) {
      l.e("DioException: ${e.message}, Response: ${e.response}");
      rethrow;
    } on FormatException catch (e) {
      l.e("FormatException: $e");
      rethrow;
    } on Object catch (e) {
      l.e("Error: $e");
      rethrow;
    }
  }

  ///refreshes access token
  static Future<void> refreshAccessToken() async {
    debugPrint("\n\nrefreshAccessToken()\n\n");
    final String? refreshToken =
        await AppStorage.$read(key: StorageKey.refreshToken);

    if (refreshToken != null) {
      try {
        final Dio dio = await initDio(); // Initialize Dio without any token
        debugPrint("${ApiConst.baseUrl}${ApiConst.refreshToken}");
        debugPrint(refreshToken);
        final response = await dio.post(
          ApiConst.refreshToken,
          data: {"refresh": refreshToken},
        );

        if (response.statusCode == 200 && response.data != null) {
          final String? newAccessToken = response.data['access'];

          if (newAccessToken != null) {
            await AppStorage.$write(
                key: StorageKey.accessToken, value: newAccessToken);
            l.i("Access token was refreshed successfully");
          } else {
            l.e("Failed to get a new access token");
            // Handle this case, maybe force logout or request login
          }
        } else {
          l.e("Token refresh failed with status code: ${response.statusCode}");
          // Handle token refresh failure, e.g., log the user out or prompt re-login
        }
      } on DioException catch (e) {
        l.e("Failed to refresh token: ${e.response}");
        // Handle specific API errors, e.g., unauthorized refresh token
        rethrow;
      } catch (e) {
        l.e("Unexpected error during token refresh: $e");
        rethrow;
      }
    } else {
      l.e("No refresh token found, please log in again.");
      // Handle this case, maybe force logout or request login
    }
  }
}

extension ListFileToFormData on List<File> {
  Future<FormData> mappedFormData({required bool isPickedFile}) async =>
      FormData.fromMap(
        <String, MultipartFile>{
          for (final File v in this) ...<String, MultipartFile>{
            DateTime.now().toString(): MultipartFile.fromBytes(
              isPickedFile
                  ? v.readAsBytesSync()
                  : (await rootBundle.load(v.path)).buffer.asUint8List(),
              filename: v.path.substring(v.path.lastIndexOf("/")),
            ),
          },
        },
      );
}

bool isAccessTokenExpired(String token) {
  final List<String> tokenParts = token.split('.');
  if (tokenParts.length != 3) return true;

  final String payload =
      utf8.decode(base64Url.decode(base64Url.normalize(tokenParts[1])));
  final Map<String, dynamic> payloadMap = json.decode(payload);

  final int expiry = payloadMap['exp'] * 1000;
  final int now = DateTime.now().millisecondsSinceEpoch;

  return now >= expiry;
}
