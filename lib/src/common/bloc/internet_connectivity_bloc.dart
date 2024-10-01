import 'dart:async';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:internet_connection_checker/internet_connection_checker.dart';
import 'internet_connectivity_event.dart';
import 'internet_connectivity_state.dart';

class ConnectivityBloc extends Bloc<ConnectivityEvent, ConnectivityState> {
  final Connectivity _connectivity;
  late StreamSubscription<List<ConnectivityResult>> _connectivitySubscription;

  ConnectivityBloc({required Connectivity connectivity})
      : _connectivity = connectivity,
        super(ConnectivityInitial()) {
    _connectivitySubscription = _connectivity.onConnectivityChanged.listen(
      (List<ConnectivityResult> results) async {
        ConnectivityResult result = results.first;
        bool isConnected = result != ConnectivityResult.none;
        if (isConnected) {
          isConnected = await InternetConnectionChecker().hasConnection;
        }
        add(ConnectivityChanged(isConnected: isConnected));
      },
    );

    on<ConnectivityChanged>((event, emit) {
      if (event.isConnected) {
        emit(ConnectivityConnected());
      } else {
        emit(ConnectivityDisconnected());
      }
    });
  }

  @override
  Future<void> close() {
    _connectivitySubscription.cancel();
    return super.close();
  }
}
