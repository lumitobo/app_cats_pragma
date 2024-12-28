
import '../entities/cat.dart';

abstract class CatLocalDatasource {

  Future<List<Cat>> getCats();
  Future<bool> saveCats(List<Cat> cats);


}