abstract class ConnectivityEvent {
  const ConnectivityEvent();

  List<Object> get props => [];
}

class ConnectivityChanged extends ConnectivityEvent {
  final bool isConnected;

  const ConnectivityChanged({required this.isConnected});

  @override
  List<Object> get props => [isConnected];
}
