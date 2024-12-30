
import 'package:catsBreed/domain/datasources/cat_network_datasource.dart';
import 'package:catsBreed/domain/enums/error_messages.dart';
import 'package:catsBreed/infrastructure/datasources/cat_network_datasource_impl.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:http/http.dart' as http;
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'cat_network_datasource_impl_test.mocks.dart';

@GenerateMocks([http.Client])
void main() {
  late CatNetworkDatasource networkDatasource;
  late MockClient mockClient;

  setUp(() {
    mockClient = MockClient();
    networkDatasource = CatNetworkDatasourceImpl(client: mockClient);
  });

  group('CatNetworkDatasource', ()
  {
    late String tResponse;
    setUpAll((){
      tResponse = '''[
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
    ]''';
    });

    test('debe retornar error cuando falla el mapeo', () async {
      when(mockClient.get(
          any,
          headers: anyNamed('headers')
      )).thenAnswer((_) async => http.Response('''[{
        "id": null,
        "name": 123,
        "origin": true,
        "country_codes": {},
        "country_code": [],
        "intelligence": "no number",
        "errorForced": "true"
      }]''', 200));

      final result = await networkDatasource.getCats();
      expect(result, Left(ErrorMessages.responseNotMapped));
    });

    test('debe regresar una lista de gatos cuando la respuesta es 200', () async {
      when(
          mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(tResponse, 200)
      );

      final result = await networkDatasource.getCats();
      expect(result.isRight(), true);
    });

    test('Debe regresar un error cuando falla la peticion', () async {
      when(
          mockClient.get(any, headers: anyNamed('headers')))
          .thenAnswer((_) async => http.Response(tResponse, 400)
      );

      final result = await networkDatasource.getCats();

      expect(result.isLeft(), true);
    });


  });
}