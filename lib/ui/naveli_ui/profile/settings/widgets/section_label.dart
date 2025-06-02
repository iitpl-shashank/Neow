import 'package:flutter/material.dart';

class SectionLabel extends StatelessWidget {
  final String title;

  const SectionLabel({super.key, required this.title});

  @override
  Widget build(BuildContext context) {
    return RichText(
      text: TextSpan(
        text: title.split(' ').first,
        style: const TextStyle(
          backgroundColor: Colors.yellow,
          color: Colors.black,
          fontWeight: FontWeight.bold,
        ),
        children: [
          TextSpan(
            text: ' ${title.split(' ').sublist(1).join(' ')}',
            style: const TextStyle(
              backgroundColor: Colors.transparent,
              fontWeight: FontWeight.normal,
            ),
          ),
        ],
      ),
    );
  }
}
