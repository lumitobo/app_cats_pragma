// test/repositories/cat_repository_test.dart

import 'package:CatsBreed/domain/datasources/cat_local_datasource.dart';
import 'package:CatsBreed/domain/datasources/cat_network_datasource.dart';
import 'package:CatsBreed/domain/entities/cat.dart';
import 'package:CatsBreed/domain/enums/conectivity_status_enum.dart';
import 'package:CatsBreed/domain/enums/error_messages.dart';
import 'package:CatsBreed/infrastructure/repositories/cat_repository_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/mockito.dart';
import 'package:mockito/annotations.dart';

import 'cat_repository_impl_test.mocks.dart';

@GenerateMocks([CatLocalDatasource, CatNetworkDatasource])
void main() {
  late CatRepositoryImpl repository;
  late MockCatLocalDatasource mockLocalDatasource;
  late MockCatNetworkDatasource mockNetworkDatasource;
  late List<Cat> cats;

  setUpAll((){
    mockLocalDatasource = MockCatLocalDatasource();
    mockNetworkDatasource = MockCatNetworkDatasource();
    cats = [
      Cat(
        id: "2",            name: "Lunatico",
        origin: "Colombia", countryCodes: "+57",
        countryCode: "+57", description: "Gato hembra que fue macho",
        intelligence: 5,    referenceImageId: "5d8721",
        adaptability: 5,    lifeSpan: "1 - 5"
      )
    ];
  });

  setUp(() {
    repository = CatRepositoryImpl(
        localDatasource: mockLocalDatasource,
        networkDatasource: mockNetworkDatasource,
        conectivityStatus: ConnectivityStatus.isConnected
    );
  });

  group('getCats', () {
    test('Debe mostrar un mensaje de error cuando haya un problema al acceder a la api de gatos.', () async {
      when(mockNetworkDatasource.getCats()).thenAnswer((_) async => Left(ErrorMessages.serverError));
      final result = await repository.getCats();
      expect(result, Left(ErrorMessages.serverError));
    });

    test('Debe mostrar un mensaje de error al mappear la respuesta de la api.', () async {
      when(mockNetworkDatasource.getCats()).thenAnswer((_) async => Left(ErrorMessages.responseNotMapped));
      final result = await repository.getCats();
      expect(result, Left(ErrorMessages.responseNotMapped));
    });

    test('Debe regresar el listado de gatos desde la api de internet.', () async {
      when(mockNetworkDatasource.getCats()).thenAnswer((_) async => Right(cats));
      when(mockLocalDatasource.saveCats(cats)).thenAnswer((_) async => true);

      final result = await repository.getCats();

      expect(result, Right(cats));
      verify(mockNetworkDatasource.getCats()).called(3);
      verify(mockLocalDatasource.saveCats(cats)).called(1);
    });

    test('Debe regresar los gatos almacenados en caché cuando esté ofnline.', () async{

      repository = CatRepositoryImpl(
          localDatasource: mockLocalDatasource,
          networkDatasource: mockNetworkDatasource,
          conectivityStatus: ConnectivityStatus.isDisonnected
      );

      when(mockLocalDatasource.getCats()).thenAnswer((_) async => Right(cats));

      final result = await repository.getCats();
      expect(result, Right(cats));
    });

    test('Debe regresar la lista de gatos vacia cuando se intenta acceder al cache y aun no se han cargado los gatos desde internet.', () async{

      repository = CatRepositoryImpl(
          localDatasource: mockLocalDatasource,
          networkDatasource: mockNetworkDatasource,
          conectivityStatus: ConnectivityStatus.isDisonnected
      );

      when(mockLocalDatasource.getCats()).thenAnswer((_) async => Left(ErrorMessages.emptyCache));

      final result = await repository.getCats();
      expect(result, Left(ErrorMessages.emptyCache));
    });

  });

}