import 'package:flutter/material.dart';

import '../../../domain/entities/cat.dart';
import 'info_rich_text.dart';

class CatInfo extends StatelessWidget {
  final Cat cat;
  const CatInfo({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.start,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text('Description:', style: TextStyle(color: Colors.black, fontSize: 18, fontWeight: FontWeight.w500)),
              Text(cat.description, style: const TextStyle(fontSize: 17)),
              InfoRichText(title: 'Origin', value: cat.origin),
              InfoRichText(title: 'Intelligence', value: cat.intelligence.toString()),
              InfoRichText(title: 'Life span', value: cat.lifeSpan ?? ''),
              InfoRichText(title: 'Adaptability', value: cat.adaptability.toString()),
              const Divider(),
            ],
          ),
        )
      )
    );
  }
}
