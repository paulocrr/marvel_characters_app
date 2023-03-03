import 'package:flutter/material.dart';

class BulletText extends StatelessWidget {
  final String text;

  const BulletText({
    super.key,
    required this.text,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        const Text(
          "\u2022",
          style: TextStyle(fontSize: 24),
        ),
        const SizedBox(width: 8),
        Expanded(child: Text(text))
      ],
    );
  }
}
