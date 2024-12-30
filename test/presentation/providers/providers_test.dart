import 'package:catsBreed/domain/entities/cat.dart';
import 'package:catsBreed/domain/enums/conectivity_status_enum.dart';
import 'package:catsBreed/domain/repositories/cat_repository.dart';
import 'package:catsBreed/presentation/providers/catDatasourcesProviders.dart';
import 'package:catsBreed/presentation/providers/catProvider.dart';
import 'package:catsBreed/presentation/providers/catRepositoryProvider.dart';
import 'package:catsBreed/presentation/providers/internetCheckProvider.dart';
import 'package:catsBreed/presentation/providers/sharedPreferencesProvider.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import '../../infrastructure/datasources/cat_local_datasource_impl_test.mocks.dart';
import '../../infrastructure/repositories/cat_repository_impl_test.mocks.dart';
import 'providers_test.mocks.dart';

@GenerateMocks([CatRepository])
void main() {
  test('catRepositoryProvider debe devolver una instancia de CatRepository', () {
    WidgetsFlutterBinding.ensureInitialized();
    final container = ProviderContainer(
      overrides: [
        sharedPreferencesProvider.overrideWithValue(MockSharedPreferences()),
      ],
    );

    expect(container.read(catRepositoryProvider), isA<CatRepository>());
  });

  test('Debe cargar gatos correctamente al inicializar el CatNotifier', () async {
    final mockRepository = MockCatRepository();

    final cats = [
      Cat(id: '1', name: 'Luna', origin: 'Colombia', countryCodes: 'CO', countryCode: 'CO', description: 'Un gato', intelligence: 5, referenceImageId: 'img1', adaptability: 5, lifeSpan: '12-15'),
      Cat(id: '2', name: 'Simba', origin: 'USA', countryCodes: 'US', countryCode: 'US', description: 'Otro gato', intelligence: 8, referenceImageId: 'img2', adaptability: 4, lifeSpan: '10-12'),
    ];

    when(mockRepository.getCats()).thenAnswer((_) async => Right(cats));

    final container = ProviderContainer(
      overrides: [
        catRepositoryProvider.overrideWithValue(mockRepository),
      ],
    );

    final notifier = container.read(catProvider.notifier);
    expect(notifier.state.isLoading, true);

    await notifier.loadAllCats();

    expect(notifier.state.isLoading, false);
    expect(notifier.state.cats, cats);
  });

  test('El estado inicial debe ser ConnectivityStatus.isConnected', () {
    WidgetsFlutterBinding.ensureInitialized();
    final notifier = ConnectivityStatusNotifier();
    expect(notifier.state, ConnectivityStatus.isConnected);
  });

}