
import 'package:cats_pragma/domain/datasources/cat_network_datasource.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';
import '../../infrastructure/datasources/cat_network_datasource_impl.dart';
import '../../infrastructure/repositories/cat_repository_impl.dart';
import 'package:http/http.dart' as http;

import 'catRepositoryProvider.dart';



class CatState {
  final List<Cat> cats;
  final bool isLoading;
  final bool isSaving;

  CatState({
    required this.cats,
    this.isLoading = true,
    this.isSaving = false,
  });

  CatState copyWith({
    List<Cat>? cats,
    bool? isLoading,
    bool? isSaving,
  }) {
    return CatState(
      cats: cats ?? this.cats,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
    );
  }

}

class CatNotifier extends StateNotifier<CatState> {

  final CatRepository catRepository;

  CatNotifier({
    required this.catRepository
  }) : super(CatState(cats: [])){
    loadAllCats();
  }

  Future<void> loadAllCats() async {

    try {
      state = state.copyWith(isLoading: true);
      final List<Cat> cats = await catRepository.getCats();
      state = state.copyWith(isLoading: false, cats: cats);
    } catch (e) {
      print(e);
    }

  }


}

final catProvider = StateNotifierProvider<CatNotifier, CatState>((ref) {
  final repository = ref.watch(catRepositoryProvider);
  return CatNotifier(catRepository: repository);
});
