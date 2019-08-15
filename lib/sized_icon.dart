import 'package:flutter/material.dart';

class SizedIcon extends StatelessWidget {
  const SizedIcon({
    Key key,
    this.initSize,
    this.magnificant,
    this.opacity = 1.0,
  }) : super(key: key);

  final initSize;
  final magnificant;
  final opacity;

  @override
  Widget build(BuildContext context) {
    return Transform.scale(
      scale: magnificant,
      alignment: Alignment.bottomCenter,
      child: Opacity(
        opacity: opacity,
        child: Container(
          width: initSize,
          height: initSize,
          decoration: BoxDecoration(
            shape: BoxShape.circle,
            color: Colors.amber,
          ),
        ),
      ),
    );
  }
}
