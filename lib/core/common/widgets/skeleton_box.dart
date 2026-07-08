import 'dart:async';

import 'package:flutter/material.dart';

/// A pulsing placeholder rectangle used as a loading skeleton.
class SkeletonBox extends StatefulWidget {
  const SkeletonBox({
    required this.width,
    required this.height,
    super.key,
    this.borderRadius = 8,
  });

  final double width;
  final double height;
  final double borderRadius;

  @override
  State<SkeletonBox> createState() => _SkeletonBoxState();
}

class _SkeletonBoxState extends State<SkeletonBox>
    with SingleTickerProviderStateMixin {
  late final AnimationController _ctrl;
  late final Animation<double> _opacity;

  @override
  void initState() {
    super.initState();
    _ctrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    unawaited(_ctrl.repeat(reverse: true));
    _opacity = Tween<double>(begin: 0.3, end: 0.7).animate(
      CurvedAnimation(parent: _ctrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _ctrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final reduceMotion = MediaQuery.disableAnimationsOf(context);
    final color = Theme.of(context).colorScheme.surfaceContainerHighest;
    return AnimatedBuilder(
      animation: _opacity,
      builder: (_, child) => Container(
        width: widget.width,
        height: widget.height,
        decoration: BoxDecoration(
          color: color.withAlpha(
            reduceMotion ? 120 : (_opacity.value * 255).round(),
          ),
          borderRadius: BorderRadius.circular(widget.borderRadius),
        ),
      ),
    );
  }
}

/// A column of skeleton rows mimicking a list of cards.
class SkeletonList extends StatelessWidget {
  const SkeletonList({super.key, this.itemCount = 4, this.itemHeight = 72});

  final int itemCount;
  final double itemHeight;

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      physics: const NeverScrollableScrollPhysics(),
      itemCount: itemCount,
      padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
      separatorBuilder: (_, i) => const SizedBox(height: 10),
      itemBuilder: (_, i) => SkeletonBox(
        width: double.infinity,
        height: itemHeight,
        borderRadius: 16,
      ),
    );
  }
}
