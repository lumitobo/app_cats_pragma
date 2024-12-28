
import '../entities/cat.dart';

abstract class CatNetworkDatasource {

  Future<List<Cat>> getCats();
  // Future<Unit> cachePosts(List<CatModel> catModels);

}