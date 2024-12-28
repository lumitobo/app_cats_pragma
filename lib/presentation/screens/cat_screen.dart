
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../domain/entities/cat.dart';
import '../shared/widgets/cat_info.dart';

class CatScreen extends StatelessWidget {
  final Cat? cat;
  const CatScreen({
    super.key,
    required this.cat,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(
          cat!.name,
          style: const TextStyle(color: Colors.black),
        ),
        leading: const BackButton(
          color: Colors.black,
        ),
      ),
      body: Column(
        children: [
          CachedNetworkImage(
            imageUrl: cat!.getImage,
            fit: BoxFit.cover,
            width: double.infinity,
            height: MediaQuery.of(context).size.height / 2.2,
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(),
            ),
            errorWidget: (context, url, error) => const Text('ERROR_IMAGE_NETWORK'),
          ),
          const SizedBox(height: 10,),
          CatInfo(cat: cat!)
        ],
      ),
    );
  }
}
