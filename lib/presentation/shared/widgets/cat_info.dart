import 'package:flutter/material.dart';

import '../../../domain/entities/cat.dart';

class CatInfo extends StatelessWidget {
  final Cat cat;
  const CatInfo({super.key, required this.cat});

  @override
  Widget build(BuildContext context) {
    return Expanded(
        child: SingleChildScrollView(
            child: Column(
      mainAxisAlignment: MainAxisAlignment.start,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
            margin: const EdgeInsets.only(
              left: 16,
              right: 16,
              top: 4,
            ),
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'NAME: ',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              TextSpan(
                  text: cat.name,
                  style: const TextStyle(fontSize: 18, color: Colors.black))
            ]))),
        Container(
            margin: const EdgeInsets.all(16),
            child: const Text('DESCRIPTION',
                style: TextStyle(color: Colors.black, fontSize: 18))),
        Container(
          margin: const EdgeInsets.only(left: 16, right: 16, bottom: 12),
          child: Text(
            cat.description,
            style: const TextStyle(fontSize: 18),
          ),
        ),
        Container(
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 12),
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'ORIGIN: ',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              TextSpan(
                  text: cat.origin,
                  style: const TextStyle(fontSize: 18, color: Colors.black))
            ]))),
        Container(
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 12),
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'INTELLIGENCE: ',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 18,
                  )),
              TextSpan(
                  text: cat.intelligence.toString(),
                  style: const TextStyle(fontSize: 18, color: Colors.black))
            ]))),
        Container(
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 12),
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'LIFE_SPAN: ',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              TextSpan(
                  text: cat.lifeSpan,
                  style: const TextStyle(fontSize: 18, color: Colors.black))
            ]))),
        Container(
            margin:
                const EdgeInsets.only(left: 16, right: 16, top: 2, bottom: 12),
            child: RichText(
                text: TextSpan(children: [
              const TextSpan(
                  text: 'ADAPTABILITY: ',
                  style: TextStyle(color: Colors.black, fontSize: 18)),
              TextSpan(
                  text: cat.adaptability.toString(),
                  style: const TextStyle(fontSize: 18, color: Colors.black))
            ]))),
      ],
    )));
  }
}
