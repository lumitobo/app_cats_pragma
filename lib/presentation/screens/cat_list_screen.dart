
import 'package:cats_pragma/presentation/providers/catProvider.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

import '../providers/internetCheckProvider.dart';
import '../shared/widgets/cat_card_widget.dart';
class CatListScreen extends StatelessWidget {
  const CatListScreen({super.key});

  @override
  Widget build(BuildContext context) {

    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Cats',
          style: TextStyle(color: Colors.black),
        ),
      ),
      body: CatListView()
    );
  }

}


class CatListView extends ConsumerWidget {
  const CatListView({super.key});

  @override
  Widget build(BuildContext context, WidgetRef ref) {
    final catState = ref.watch(catProvider);
    final connectivityStatusProvider = ref.watch(connectivityStatusProviders);


    WidgetsBinding.instance.addPostFrameCallback((_) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text(
            connectivityStatusProvider == ConnectivityStatus.isConnected ? 'Is Connected to Internet' : 'Is Disconnected from Internet',
            style: const TextStyle(
              color: Colors.white,
              fontSize: 20.0,
            ),
          ),
          backgroundColor: connectivityStatusProvider == ConnectivityStatus.isConnected ? Colors.green : Colors.red,
        ),
      );
    });


    if (catState.isLoading) {
      return Center(child: CircularProgressIndicator());
    }

    return ListView.builder(
      itemCount: catState.cats.length,
      itemBuilder: (context, index) {
        final cat = catState.cats[index];
        return Column(
          children: [
            if(index == 0)
            Text(
              connectivityStatusProvider == ConnectivityStatus.isConnected ? 'Is Connected to Internet' : 'Is Disconnected from Internet',
              style: const TextStyle(
                color: Colors.black,
                fontSize: 20.0,
              ),
            ),
            CatCardWidget(cat: cat),
          ],
        );
      },
    );
  }
}