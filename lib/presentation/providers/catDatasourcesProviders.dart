import 'package:CatsBreed/domain/datasources/cat_local_datasource.dart';
import 'package:CatsBreed/presentation/providers/sharedPreferencesProvider.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../domain/datasources/cat_network_datasource.dart';
import '../../infrastructure/datasources/cat_local_datasource_impl.dart';
import '../../infrastructure/datasources/cat_network_datasource_impl.dart';
import 'package:http/http.dart' as http;

final catLocalDataSourceProvider = Provider<CatLocalDatasource>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return CatLocalDatasourceImpl(sharedPreferences: sharedPrefs);
});


final catNetworkDataSourceProvider = Provider<CatNetworkDatasource>((ref) {
  return CatNetworkDatasourceImpl(client: http.Client());
});

