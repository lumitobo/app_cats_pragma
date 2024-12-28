import 'dart:convert';

import 'package:cats_pragma/domain/datasources/cat_network_datasource.dart';
import 'package:cats_pragma/domain/entities/cat.dart';
import 'package:cats_pragma/infrastructure/mappers/cat_mapper.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../models/cat_model.dart';


const baseUrl = "api.thecatapi.com";

class CatNetworkDatasourceImpl implements CatNetworkDatasource {

  final http.Client client;
  CatNetworkDatasourceImpl({required this.client});

  @override
  Future<List<Cat>> getCats() async {
    final response = await client.get(
      Uri.https(baseUrl, '/v1/breeds'),
      headers: {'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'},
    );


    if (response.statusCode == 200) {
      List<Cat> listCats = [];
      final List decodedJson = json.decode(response.body) as List;
      try {
        decodedJson.map<CatModel>((jsonCatModel) => CatModel.fromJson(jsonCatModel)).toList();
        final List<CatModel> catModels = decodedJson.map<CatModel>((jsonCatModel) => CatModel.fromJson(jsonCatModel)).toList();

        listCats = catModels.map((oferta) => CatNetworkMapper.cataModelToEntity(oferta)).toList();

      } catch (e) {
        debugPrint(e.toString());
      }

      return listCats;

    } else {
      throw Exception();
    }
  }
}