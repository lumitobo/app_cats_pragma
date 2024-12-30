import 'dart:async';

import 'package:catsBreed/domain/enums/conectivity_status_enum.dart';
import 'package:catsBreed/presentation/providers/internetCheckProvider.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'conectiviy_test.mocks.dart';

@GenerateMocks([Connectivity])
void main() {
  late ConnectivityStatusNotifier notifier;
  late MockConnectivity mockConnectivity;
  late StreamController<List<ConnectivityResult>> streamController;

  setUp(() {
    mockConnectivity = MockConnectivity();
    streamController = StreamController<List<ConnectivityResult>>();

    when(mockConnectivity.onConnectivityChanged).thenAnswer((_) => streamController.stream);
    notifier = ConnectivityStatusNotifier(connectivity: mockConnectivity);
  });

  tearDown(() {
    streamController.close();
  });

  test('Debe iniciar con estado conectado', () {
    expect(notifier.state, equals(ConnectivityStatus.isConnected));
  });

  test('Debe cambiar a desconectado cuando no hay conexion', () async {
    streamController.add([ConnectivityResult.none]);

    await Future.delayed(Duration.zero);
    expect(notifier.state, equals(ConnectivityStatus.isDisonnected));
  });

  test('Debe cambiar a conectado cuando hay alguna conexion', () async {
    streamController.add([ConnectivityResult.wifi]);

    await Future.delayed(Duration.zero);

    expect(notifier.state, equals(ConnectivityStatus.isConnected));
  });

  test('No debe cambiar el estado si el nuevo estado es igual al anterior', () async {
    streamController.add([ConnectivityResult.wifi]);
    await Future.delayed(Duration.zero);

    streamController.add([ConnectivityResult.wifi]);
    await Future.delayed(Duration.zero);

    expect(notifier.state, equals(ConnectivityStatus.isConnected));
  });
}