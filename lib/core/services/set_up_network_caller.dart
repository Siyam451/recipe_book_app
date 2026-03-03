import 'api_caller.dart';

NetworkCaller getNetworkcaller() {
  NetworkCaller networkCaller = NetworkCaller(
    headers: {
      'Content-Type': 'application/json',
    },
    onUnauthorize: () {
      // TODO: navigate to login
    },
  );

  return networkCaller;
}