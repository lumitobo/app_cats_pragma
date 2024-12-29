

import 'package:CatsBreed/presentation/providers/catDatasourcesProviders.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/repositories/cat_repository.dart';
import '../../infrastructure/repositories/cat_repository_impl.dart';
import 'internetCheckProvider.dart';

final catRepositoryProvider = Provider<CatRepository>((ref) {
  final localDatasource = ref.watch(catLocalDataSourceProvider);
  final networkDatasource = ref.watch(catNetworkDataSourceProvider);
  final connectivityStatus = ref.watch(connectivityStatusProvider);

  return CatRepositoryImpl(localDatasource: localDatasource, networkDatasource: networkDatasource, conectivityStatus: connectivityStatus);
});