
import 'package:flutter_riverpod/flutter_riverpod.dart';
import '../../domain/entities/cat.dart';
import '../../domain/repositories/cat_repository.dart';

import 'catRepositoryProvider.dart';


class CatState {
  final List<Cat> cats;
  final bool isLoading;
  final bool isSaving;
  final String errorMessage;
  final String search;

  CatState({
    required this.cats,
    this.isLoading = true,
    this.isSaving = false,
    this.errorMessage = '',
    this.search = '',
  });

  CatState copyWith({
    List<Cat>? cats,
    bool? isLoading,
    bool? isSaving,
    String? errorMessage,
    String? search,
  }) {
    return CatState(
      cats: cats ?? this.cats,
      isLoading: isLoading ?? this.isLoading,
      isSaving: isSaving ?? this.isSaving,
      errorMessage: errorMessage ?? this.errorMessage,
      search: search ?? this.search,
    );
  }

  List<Cat> get filteredCats {
    if(search == ''){
      return cats;
    }
    else{
      return cats.where((task) => task.name.toLowerCase().contains(search)).toList();
    }
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

      final result = await catRepository.getCats();
      result.fold(
        (error) => state = state.copyWith(isLoading: false, errorMessage: error.message),
        (cats) => state = state.copyWith(isLoading: false, cats: cats),
      );

    } catch (e) {
      print(e);
    }

  }

  void searchCats(String value) async {
    state = state.copyWith(search: value);
  }

}

final catProvider = StateNotifierProvider<CatNotifier, CatState>((ref) {
  final repository = ref.watch(catRepositoryProvider);
  return CatNotifier(catRepository: repository);
});
