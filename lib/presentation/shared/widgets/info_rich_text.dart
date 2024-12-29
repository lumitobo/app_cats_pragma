import 'package:flutter/material.dart';

class InfoRichText extends StatelessWidget {
  final String title;
  final String value;
  final double fontSize;
  final Color textColor;

  const InfoRichText({
    super.key,
    required this.title,
    required this.value,
    this.fontSize = 18,
    this.textColor = Colors.black,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const Divider(),
        RichText(
          text: TextSpan(
            children: [
              TextSpan(
                text: '$title: ',
                style: TextStyle(color: textColor, fontSize: fontSize, fontWeight: FontWeight.w500)
              ),
              TextSpan(
                text: value,
                style: TextStyle(fontSize: fontSize, color: textColor)
              )
            ]
          )
        ),
      ],
    );
  }
}