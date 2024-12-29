import 'package:flutter/material.dart';

import '../shared/widgets/cat_list_view.dart';
import '../shared/widgets/search_bar.dart';
class CatListScreen extends StatelessWidget {
  const CatListScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('CatsBreed', style: TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
        centerTitle: true,
      ),
      body: CatListView(),
    );
  }

}