import 'package:flutter/material.dart';

class AppBarClipper extends CustomClipper<Path> {

  AppBarClipper({this.iconOffsetY = 0.0, this.radius = 40});

  final iconOffsetY;
  final radius;

  @override
  Path getClip(Size size) {
    Path path = Path();
    Path clip = Path();
    Rect icon = Rect.fromCircle(center: Offset(60 ,iconOffsetY), radius: radius);

    clip.addOval(icon);

    path.lineTo(0, size.height);
    path.lineTo(size.width, size.height);
    path.lineTo(size.width, 0.0);
    path.close();

    path = Path.combine(PathOperation.difference, path, clip);
    return path;
  }

  @override
  bool shouldReclip(AppBarClipper oldClipper) {
    return true;
  }
}
