import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

import '../../../domain/entities/cat.dart';

class CatCardWidget extends StatelessWidget {
  final Cat cat;
  const CatCardWidget({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15),
      child: Card(
        // shadowColor: Colors.purple,
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(15)),
        elevation: 5,
        margin: const EdgeInsets.symmetric(vertical: 10),
        child: Column(
          children: [
            Padding(
              padding: const EdgeInsets.only(top: 8, right: 10, bottom: 8, left:  15),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(child: Text(cat.name, style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold))),
                  TextButton(
                    onPressed: () {
                      context.push('/cat', extra: cat);
                    },
                    child: const Text('See details...', style: TextStyle(fontSize: 16, color: Colors.purple)),
                  ),
                ],
              ),
            ),
            GestureDetector(
              onTap: () => context.push('/cat', extra: cat),
              child: ClipRRect(
                borderRadius: BorderRadius.circular(5),
                child: CachedNetworkImage(
                  imageUrl: cat.getImage,
                  fit: BoxFit.cover,
                  width: double.infinity,
                  errorWidget: (context, url, error) =>  Image.asset('assets/images/no_image.jpg', fit: BoxFit.cover),
                  placeholder: (context, url) => Image.asset('assets/loaders/puntos_loading.gif', fit: BoxFit.cover),
                ),
              ),
            ),
            const SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.all(8),
                    margin: const EdgeInsets.only(left: 5, bottom: 8),
                    child: Text(
                     overflow: TextOverflow.ellipsis,
                     'Origin: ${cat.origin}',
                      style: const TextStyle(fontSize: 16),
                    ),
                  ),
                ),
                Container(
                  padding: const EdgeInsets.all(8),
                  margin: const EdgeInsets.only(right: 5, bottom: 8),
                  child: Text(
                    'Intelligence: ${cat.intelligence}',
                    style: const TextStyle(fontSize: 16),
                  ),
                ),
              ],
            )
          ],
        )
      ),
    );
  }
}