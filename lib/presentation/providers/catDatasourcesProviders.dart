
import 'package:cats_pragma/domain/datasources/cat_local_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../../domain/datasources/cat_network_datasource.dart';
import '../../infrastructure/datasources/cat_local_datasource_impl.dart';
import '../../infrastructure/datasources/cat_network_datasource_impl.dart';
import 'package:http/http.dart' as http;

import '../../main.dart';


final sharedPreferencesProvider = Provider<SharedPreferences>((ref) {
  throw UnimplementedError('SharedPreferences is not initialized. please init before running app');
});

final catLocalDataSourceProvider = Provider<CatLocalDatasource>((ref) {
  final sharedPrefs = ref.watch(sharedPreferencesProvider);
  return CatLocalDatasourceImpl(sharedPreferences: sharedPrefs);
});


final catNetworkDataSourceProvider = Provider<CatNetworkDatasource>((ref) {
  return CatNetworkDatasourceImpl(client: http.Client());
});

