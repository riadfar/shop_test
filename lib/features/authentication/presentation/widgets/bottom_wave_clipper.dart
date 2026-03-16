import 'package:flutter/material.dart';

class BottomWaveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) {
    final path = Path()..lineTo(0, size.height - 52);

    path.quadraticBezierTo(
      size.width * 0.25, size.height + 4,
      size.width * 0.50, size.height - 26,
    );

    path.quadraticBezierTo(
      size.width * 0.76, size.height - 58,
      size.width, size.height - 18,
    );

    path.lineTo(size.width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(BottomWaveClipper oldClipper) => false;
}