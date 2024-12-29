
import '../entities/cat.dart';
import 'package:dartz/dartz.dart';

import '../enums/error_messages.dart';

abstract class CatRepository {
  Future<Either<ErrorMessages, List<Cat>>> getCats();
}