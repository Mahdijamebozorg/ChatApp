enum ConnectivityState {
  noInternetConnection,
  clientError,
  serverError,
  waiting,
  connecting,
  updating,
  connected,
}

String getConnectivityState(ConnectivityState state) {
  switch (state) {
    case ConnectivityState.noInternetConnection:
      return "No internet connection!";

    case ConnectivityState.clientError:
      return "VPN needed in your region!";

    case ConnectivityState.serverError:
      return "Server error!";

    case ConnectivityState.waiting:
      return "Waiting for internet...";

    case ConnectivityState.connecting:
      return "Connecting...";

    case ConnectivityState.updating:
      return "Updating";

    case ConnectivityState.connected:
      return "Connected!";

    default:
      return "Unknow state!";
  }
}
