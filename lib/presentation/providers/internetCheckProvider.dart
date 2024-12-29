import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/enums/conectivity_status_enum.dart';

class ConnectivityStatusNotifier extends StateNotifier<ConnectivityStatus> {

  ConnectivityStatus? lastResult;
  ConnectivityStatus? newState;

  ConnectivityStatusNotifier() : super(ConnectivityStatus.isConnected) {
    if (state == ConnectivityStatus.isConnected) {
      lastResult = ConnectivityStatus.isConnected;
    } else {
      lastResult = ConnectivityStatus.isDisonnected;
    }
    lastResult = ConnectivityStatus.notDetermined;

    Connectivity().onConnectivityChanged.listen((List<ConnectivityResult> result) {
      switch (result.first) {
        case ConnectivityResult.none:
          newState = ConnectivityStatus.isDisonnected;
          break;
        default:
          newState = ConnectivityStatus.isConnected;
      }

      if (newState != lastResult) {
        state = newState!;
        lastResult = newState;
      }

    });
  }
}

final connectivityStatusProvider = StateNotifierProvider<ConnectivityStatusNotifier, ConnectivityStatus>((ref) {
  return ConnectivityStatusNotifier();
});