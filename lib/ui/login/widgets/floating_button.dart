import 'package:flutter/material.dart';

class FloatingButton extends StatelessWidget {
  final double width;
  final double height;
  final IconData icon;
  final Color iconColor;
  final double iconSize;
  final VoidCallback onPressed;
  const FloatingButton({
    super.key,
    required this.onPressed,
    this.width = 70,
    this.height = 70,
    this.icon = Icons.arrow_forward,
    this.iconColor = Colors.white,
    this.iconSize = 50,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned(
      bottom: -40,
      left: 0,
      right: 0,
      child: Center(
        child: Container(
          width: 86,
          height: 86,
          decoration: const BoxDecoration(
            color: Color.fromARGB(255, 32, 32, 32),
            shape: BoxShape.circle,
            boxShadow: [
              BoxShadow(
                color: Colors.black26,
                offset: Offset(0, 6),
              ),
            ],
          ),
          child: Center(
            child: Container(
              width: width,
              height: height,
              decoration: const BoxDecoration(
                gradient: LinearGradient(
                  colors: [
                    Color(0xFF4CAF50),
                    Color(0xFF8BC34A),
                  ],
                ),
                shape: BoxShape.circle,
              ),
              child: IconButton(
                onPressed: onPressed,
                icon: Icon(
                  icon,
                  color: iconColor,
                  size: iconSize,
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
