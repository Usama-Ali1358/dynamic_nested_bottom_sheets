import 'dart:ui';
import 'package:flutter/material.dart';

class SheetBackdrop extends StatelessWidget {
  final double blur;
  final Color color;

  const SheetBackdrop({
    this.blur = 12,
    this.color = const Color(0x80000000),
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Positioned.fill(
      child: BackdropFilter(
        filter: ImageFilter.blur(sigmaX: blur, sigmaY: blur),
        child: Container(color: color),
      ),
    );
  }
}
