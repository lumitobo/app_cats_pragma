
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cat.dart';
import '../shared/widgets/cat_info.dart';

class CatScreen extends StatelessWidget {
  final Cat? cat;
  const CatScreen({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(cat!.name, style: const TextStyle(color: Colors.black, fontWeight: FontWeight.w800)),
        leading: const BackButton(color: Colors.black),
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: cat!.getImage,
            fit: BoxFit.cover,
            width: double.infinity,
            errorWidget: (context, url, error) =>  Image.asset('assets/images/no-image.jpg', fit: BoxFit.cover),
            placeholder: (context, url) => Image.asset('assets/loaders/puntos_loading.gif', fit: BoxFit.cover),
          ),
          const SizedBox(height: 10,),
          CatInfo(cat: cat!)
        ],
      ),
    );
  }
}
