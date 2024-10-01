abstract class ConnectivityState {
  const ConnectivityState();

  List<Object> get props => [];
}

class ConnectivityInitial extends ConnectivityState {}

class ConnectivityConnected extends ConnectivityState {}

class ConnectivityDisconnected extends ConnectivityState {}
