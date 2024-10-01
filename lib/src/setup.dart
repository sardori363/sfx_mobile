import "dart:developer";

import "package:flutter/cupertino.dart";
import "package:flutter/services.dart";
import "package:l/l.dart";
import "app.dart";
import "common/local/app_storage.dart";

Future<void> setup() async {
  WidgetsFlutterBinding.ensureInitialized();
  SystemChrome.setPreferredOrientations([
    DeviceOrientation.portraitUp,
    DeviceOrientation.portraitDown,
  ]);
  await getStorageValues();
  runApp(MyApp());
}

String? token;

Future<void> getStorageValues() async {
  token = await AppStorage.$read(key: StorageKey.accessToken);
  log("$token");
}
