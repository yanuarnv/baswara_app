import 'dart:async';

import 'package:connectivity_plus/connectivity_plus.dart';

abstract class NetworkInfo {
  Future<bool> get isConnected;
}

class NetworkInfoImpl extends NetworkInfo {
  final Connectivity connectionChecker;

  NetworkInfoImpl(this.connectionChecker);

  @override
  Future<bool> get isConnected async {
    final connResult = await connectionChecker.checkConnectivity();
    if (connResult == ConnectivityResult.mobile ||
        connResult == ConnectivityResult.wifi ||
        connResult == ConnectivityResult.ethernet) {
      return true;
    } else {
      return false;
    }
  }
}
