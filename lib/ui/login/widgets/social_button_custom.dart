import 'package:flutter/material.dart';

class SocialButtonCustom extends StatelessWidget {
  final String letter;
  final VoidCallback onTap;
  const SocialButtonCustom({
    super.key,
    required this.letter,
    required this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: SizedBox(
        width: 50,
        height: 50,
        child: Center(
          child: Text(
            letter,
            style: const TextStyle(
              color: Colors.white,
              fontSize: 30,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
    );
  }
}
