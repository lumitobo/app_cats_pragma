
import 'package:catsBreed/domain/datasources/cat_local_datasource.dart';
import 'package:catsBreed/domain/entities/cat.dart';
import 'package:catsBreed/domain/enums/error_messages.dart';
import 'package:catsBreed/infrastructure/datasources/cat_local_datasource_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';

import 'cat_local_datasource_impl_test.mocks.dart';


@GenerateMocks([SharedPreferences])
void main () {
  late CatLocalDatasource localDatasource;
  late MockSharedPreferences sharedPreferences;

  setUp((){
    sharedPreferences = MockSharedPreferences();
    localDatasource = CatLocalDatasourceImpl(sharedPreferences: sharedPreferences);
  });

  group("CatLocalDatasource", (){
    test('Debe devolver un error cuando el cache está vacío.', () async {

      when(sharedPreferences.getString('cats')).thenReturn(null);
      final result = await localDatasource.getCats();

      expect(result, Left(ErrorMessages.emptyCache));
    });

    test('Debe devolver un error cuando el cache tenga datos errados y no se pueda mapear.', () async {

      final tJsonString = '''
    [
      {
        "id": "2",
        "name": "Lunatico",
        "origin": "Colombia",
        "country_codes": "+57",
        "country_code": "+57",
        "description": "Gato test",
        "intelligence": 5,
        "reference_image_id": "test",
        "adaptability": 5,
        "life_span": "1-5",
        "errorForced": "true
      }
    ]
    ''';

      when(sharedPreferences.getString('cats')).thenReturn(tJsonString);
      final result = await localDatasource.getCats();

      expect(result, Left(ErrorMessages.responseNotMapped));
    });

    test('Debe devolver un listado de gatos cuando si existan en el cache.', () async {

      final tJsonString = '''
    [
      {
        "id": "2",
        "name": "Lunatico",
        "origin": "Colombia",
        "country_codes": "+57",
        "country_code": "+57",
        "description": "Gato test",
        "intelligence": 5,
        "reference_image_id": "test",
        "adaptability": 5,
        "life_span": "1-5"
      }
    ]
    ''';

      when(sharedPreferences.getString('cats')).thenReturn(tJsonString);
      final result = await localDatasource.getCats();

      expect(result.isRight(), true);
      expect(result.fold((l) => null, (r) => r.first.name), 'Lunatico');

    });

    test('Debe ocurrir un error en el guardado del listado de gatos.', () async {
      final cats = [
        Cat(
            id: "2",            name: "Lunatico",
            origin: "Colombia", countryCodes: "+57",
            countryCode: "+57", description: "Gato hembra que fue macho",
            intelligence: 5,    referenceImageId: "5d8721",
            adaptability: 5,    lifeSpan: "1 - 5"
        )
      ];
      when(sharedPreferences.setString(any, any)).thenAnswer((_) => Future.value(false));

      final result = await localDatasource.saveCats(cats);

      expect(result, false);

    });

    test('Debe ser exitoso el guardado del listado de gatos.', () async {
      final cats = [
        Cat(
            id: "2",            name: "Lunatico",
            origin: "Colombia", countryCodes: "+57",
            countryCode: "+57", description: "Gato hembra que fue macho",
            intelligence: 5,    referenceImageId: "5d8721",
            adaptability: 5,    lifeSpan: "1 - 5"
        )
      ];

      when(sharedPreferences.setString(any, any)).thenAnswer((_) => Future.value(true));

      final result = await localDatasource.saveCats(cats);

      expect(result, true);

    });
  });



}