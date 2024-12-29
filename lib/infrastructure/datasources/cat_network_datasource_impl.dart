import 'dart:convert';

import 'package:CatsBreed/domain/datasources/cat_network_datasource.dart';
import 'package:CatsBreed/domain/entities/cat.dart';
import 'package:CatsBreed/infrastructure/mappers/cat_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;

import '../../domain/enums/error_messages.dart';
import '../models/cat_model.dart';


const baseUrl = "api.thecatapi.com";

class CatNetworkDatasourceImpl implements CatNetworkDatasource {

  final http.Client client;
  CatNetworkDatasourceImpl({required this.client});

  @override
  Future<Either<ErrorMessages, List<Cat>>> getCats() async {
    final response = await client.get(
      Uri.https(baseUrl, '/v1/breeds'),
      headers: {'x-api-key': 'live_99Qe4Ppj34NdplyLW67xCV7Ds0oSLKGgcWWYnSzMJY9C0QOu0HUR4azYxWkyW2nr'},
    );


    if (response.statusCode == 200) {
      List<Cat> listCats = [];
      final List decodedJson = json.decode(response.body) as List;
      try {
        decodedJson.map<CatModel>((catModel) => CatModel.fromJson(catModel)).toList();
        final List<CatModel> catModels = decodedJson.map<CatModel>((catModel) => CatModel.fromJson(catModel)).toList();
        listCats = catModels.map((oferta) => CatNetworkMapper.cataModelToEntity(oferta)).toList();

      } catch (e) {
        debugPrint(e.toString());
        return left(ErrorMessages.responseNotMapped);
      }

      return Right(listCats);

    } else {
      return left(ErrorMessages.serverError);
      throw Exception();
    }
  }
}