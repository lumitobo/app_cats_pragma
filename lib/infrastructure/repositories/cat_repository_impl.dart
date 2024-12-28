


import '../../domain/datasources/cat_local_datasource.dart';
import '../../domain/datasources/cat_network_datasource.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../presentation/providers/internetCheckProvider.dart';

class CatRepositoryImpl extends CatRepository {

  final CatLocalDatasource localDatasource;
  final CatNetworkDatasource networkDatasource;
  final ConnectivityStatus conectivityStatus;

  CatRepositoryImpl({required this.localDatasource, required this.networkDatasource, required this.conectivityStatus});

  @override
  Future<List<Cat>> getCats() async {
    if(ConnectivityStatus.isConnected == conectivityStatus){
      final List<Cat> cats = await networkDatasource.getCats();
      localDatasource.saveCats(cats);
      return Future.value(cats);
    }
    else{
      final List<Cat> cats = await localDatasource.getCats();
      return cats;
    }
  }

  
}