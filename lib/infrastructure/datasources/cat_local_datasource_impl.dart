import 'dart:convert';

import 'package:catsBreed/domain/datasources/cat_local_datasource.dart';
import 'package:catsBreed/domain/entities/cat.dart';
import 'package:catsBreed/infrastructure/mappers/cat_mapper.dart';
import 'package:dartz/dartz.dart';
import 'package:flutter/cupertino.dart';
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
        // debugPrint(e.toString());
        return Left(ErrorMessages.responseNotMapped);
      }

      return Right(listCats);

    } else {
      return Left(ErrorMessages.emptyCache);
    }
  }

  @override
  Future<bool> saveCats(List<Cat> cats) {

    try{
      List catModelsToJson = cats.map<Map<String, dynamic>>((catModel) => catModel.toJson()).toList();
      return sharedPreferences.setString('cats', json.encode(catModelsToJson));
    }catch (e) {
      return Future.value(false);
    }

  }


}