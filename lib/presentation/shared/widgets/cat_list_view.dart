import 'package:CatsBreed/presentation/shared/widgets/search_bar.dart';
import 'package:CatsBreed/presentation/shared/widgets/sliver_appBar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../../../domain/enums/conectivity_status_enum.dart';
import '../../providers/catProvider.dart';
import '../../providers/internetCheckProvider.dart';
import 'cat_card.dart';


class CatListView extends ConsumerWidget {
  const CatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catState = ref.watch(catProvider);

    ref.listen(connectivityStatusProvider, (previous, next) {
      if (previous != next) {
        showConnectivitySnackbar(context, next);
      }
    });

    if (catState.isLoading) {
      return Center(child: CircularProgressIndicator(color: Colors.purple,));
    }

    return CustomScrollView(
      slivers: [
        SliverPersistentHeader(
          pinned: true,
          floating: true,
          delegate: SliverAppBarDelegate(
            minHeight: 0,
            maxHeight: 70,
            child: Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 10),
              decoration: BoxDecoration(
                color: Theme.of(context).scaffoldBackgroundColor,
                borderRadius: BorderRadius.only(bottomLeft: Radius.circular(30), bottomRight: Radius.circular(30))
              ),
              child: CustomSearchBar(),
            ),
          ),
        ),
        catState.filteredCats.isEmpty ? buildEmpty() :
        SliverList(
          delegate: SliverChildBuilderDelegate((context, index) {
            final cat = catState.filteredCats[index];
            return CatCardWidget(cat: cat);
          },
            childCount: catState.filteredCats.length,
          ),
        ),
      ]
    );
  }

  Widget buildEmpty() => const SliverFillRemaining(child: Center(child: Text("No cats to show.")));

  void showConnectivitySnackbar(BuildContext context, ConnectivityStatus status) {
    ScaffoldMessenger.of(context).hideCurrentSnackBar();
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          status == ConnectivityStatus.isConnected ? 'Is connected to Internet' : 'Is disconnected from Internet',
          style: const TextStyle(color: Colors.white, fontSize: 18),
        ),
        backgroundColor: status == ConnectivityStatus.isConnected ? Colors.green : Colors.red,
      ),
    );
  }

}