import 'package:flutter/material.dart';

class MomentumLogo extends StatelessWidget {
  const MomentumLogo({
    this.size = 40,
    this.semanticLabel = 'Momentum',
    super.key,
  });

  final double size;
  final String? semanticLabel;

  @override
  Widget build(BuildContext context) {
    return Image.asset(
      'assets/brand/momentum_logo.png',
      width: size,
      height: size,
      fit: BoxFit.contain,
      semanticLabel: semanticLabel,
    );
  }
}
