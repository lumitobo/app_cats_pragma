
import 'package:dartz/dartz.dart';

import '../entities/cat.dart';
import '../enums/error_messages.dart';

abstract class CatLocalDatasource {

  Future<Either<ErrorMessages, List<Cat>>> getCats();
  Future<bool> saveCats(List<Cat> cats);


}