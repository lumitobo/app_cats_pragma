


import 'package:dartz/dartz.dart';

import '../../domain/datasources/cat_local_datasource.dart';
import '../../domain/datasources/cat_network_datasource.dart';
import '../../domain/entities/cat.dart';
import '../../domain/enums/error_messages.dart';
import '../../domain/enums/conectivity_status_enum.dart';
import '../../domain/repositories/cat_repository.dart';

class CatRepositoryImpl extends CatRepository {

  final CatLocalDatasource localDatasource;
  final CatNetworkDatasource networkDatasource;
  final ConnectivityStatus conectivityStatus;

  CatRepositoryImpl({required this.localDatasource, required this.networkDatasource, required this.conectivityStatus});

  @override
  Future<Either<ErrorMessages, List<Cat>>> getCats() async {
    if(ConnectivityStatus.isConnected == conectivityStatus){
      final result = await networkDatasource.getCats();
      return result.fold(
        (error) {
          return Left(error);
        },
        (cats) {
          localDatasource.saveCats(cats);
          return Right(cats);
        },
      );
      // final List<Cat> cats = await networkDatasource.getCats();
      // localDatasource.saveCats(cats);
      // return Future.value(cats);
    }
    else{
      final result = await localDatasource.getCats();
      return result;
      // final List<Cat> cats = await localDatasource.getCats();
      // return cats;
    }
  }

  
}