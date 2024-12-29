import 'dart:convert';

import 'package:cats_pragma/domain/datasources/cat_local_datasource.dart';
import 'package:cats_pragma/domain/datasources/cat_network_datasource.dart';
import 'package:cats_pragma/domain/entities/cat.dart';
import 'package:cats_pragma/infrastructure/mappers/cat_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/enums/error_messages.dart';
import '../models/cat_model.dart';



class CatLocalDatasourceImpl implements CatLocalDatasource {
  final SharedPreferences sharedPreferences;

  CatLocalDatasourceImpl({required this.sharedPreferences});

  @override
  Future<Either<ErrorMessages, List<Cat>>> getCats() async {
    final jsonString = sharedPreferences.getString('cats');
    if (jsonString != null) {

      List<Cat> listCats = [];
      try {
        List decodeJsonData = json.decode(jsonString);
        List<CatModel> catModels = decodeJsonData.map<CatModel>((catModel) => CatModel.fromJson(catModel)).toList();
        listCats = catModels.map((oferta) => CatNetworkMapper.cataModelToEntity(oferta)).toList();

      } catch (e) {
        debugPrint(e.toString());
        return left(ErrorMessages.responseNotMapped);
      }

      return Right(listCats);

    } else {
      return left(ErrorMessages.emptyCache);
    }
  }

  @override
  Future<bool> saveCats(List<Cat> cats) {
    List catModelsToJson = cats.map<Map<String, dynamic>>((catModel) => catModel.toJson()).toList();
    sharedPreferences.setString('cats', json.encode(catModelsToJson));
    return Future.value(true);
  }


}