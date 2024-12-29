
import 'package:dartz/dartz.dart';

import '../entities/cat.dart';
import '../enums/error_messages.dart';

abstract class CatNetworkDatasource {

  Future<Either<ErrorMessages, List<Cat>>> getCats();

}