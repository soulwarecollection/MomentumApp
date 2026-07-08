import 'dart:async';
import 'dart:math' as math;

import 'package:flutter/material.dart';

class MomentumSplashScreen extends StatefulWidget {
  const MomentumSplashScreen({this.startupFailed = false, super.key});

  static const background = Color(0xFF09090B);
  static const brandRed = Color(0xFFFF3131);

  final bool startupFailed;

  @override
  State<MomentumSplashScreen> createState() => _MomentumSplashScreenState();
}

class _MomentumSplashScreenState extends State<MomentumSplashScreen>
    with TickerProviderStateMixin {
  late final AnimationController _entranceController;
  late final AnimationController _pulseController;
  late final Animation<double> _logoScale;
  late final Animation<double> _logoOpacity;
  late final Animation<Offset> _wordmarkPosition;
  late final Animation<double> _wordmarkOpacity;

  @override
  void initState() {
    super.initState();
    _entranceController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 900),
    );
    _pulseController = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 1400),
    );
    unawaited(_entranceController.forward());
    unawaited(_pulseController.repeat(reverse: true));

    _logoScale = Tween<double>(begin: 0.78, end: 1).animate(
      CurvedAnimation(
        parent: _entranceController,
        curve: const Interval(0, 0.72, curve: Curves.easeOutBack),
      ),
    );
    _logoOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0, 0.42, curve: Curves.easeOut),
    );
    _wordmarkPosition =
        Tween<Offset>(
          begin: const Offset(0, 0.28),
          end: Offset.zero,
        ).animate(
          CurvedAnimation(
            parent: _entranceController,
            curve: const Interval(0.28, 1, curve: Curves.easeOutCubic),
          ),
        );
    _wordmarkOpacity = CurvedAnimation(
      parent: _entranceController,
      curve: const Interval(0.28, 0.82, curve: Curves.easeOut),
    );
  }

  @override
  void dispose() {
    _entranceController.dispose();
    _pulseController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        fit: StackFit.expand,
        children: [
          const RepaintBoundary(child: CustomPaint(painter: _GridPainter())),
          const Positioned(
            top: -170,
            right: -130,
            child: _AmbientGlow(
              size: 380,
              color: Color(0x30FF3131),
            ),
          ),
          const Positioned(
            bottom: -190,
            left: -160,
            child: _AmbientGlow(
              size: 410,
              color: Color(0x1800E5FF),
            ),
          ),
          SafeArea(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: 28),
              child: Column(
                children: [
                  const Spacer(flex: 4),
                  FadeTransition(
                    opacity: _logoOpacity,
                    child: ScaleTransition(
                      scale: _logoScale,
                      child: AnimatedBuilder(
                        animation: _pulseController,
                        builder: (context, child) {
                          return Container(
                            width: 154,
                            height: 154,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(42),
                              gradient: const LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [Color(0xFF202024), Color(0xFF111114)],
                              ),
                              border: Border.all(
                                color: const Color(0x18FFFFFF),
                              ),
                              boxShadow: [
                                BoxShadow(
                                  color: MomentumSplashScreen.brandRed
                                      .withValues(
                                        alpha:
                                            0.18 + _pulseController.value * 0.1,
                                      ),
                                  blurRadius: 34 + _pulseController.value * 16,
                                  spreadRadius: -4,
                                ),
                                const BoxShadow(
                                  color: Color(0x80000000),
                                  blurRadius: 30,
                                  offset: Offset(0, 16),
                                ),
                              ],
                            ),
                            child: child,
                          );
                        },
                        child: Padding(
                          padding: const EdgeInsets.all(12),
                          child: Image.asset(
                            'assets/brand/momentum_logo.png',
                            semanticLabel: 'Momentum logo',
                          ),
                        ),
                      ),
                    ),
                  ),
                  const SizedBox(height: 34),
                  FadeTransition(
                    opacity: _wordmarkOpacity,
                    child: SlideTransition(
                      position: _wordmarkPosition,
                      child: const Column(
                        children: [
                          Text(
                            'MOMENTUM',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 25,
                              height: 1,
                              fontWeight: FontWeight.w800,
                              letterSpacing: 6.5,
                            ),
                          ),
                          SizedBox(height: 14),
                          Text(
                            'BUILD STRENGTH  ·  KEEP MOVING',
                            style: TextStyle(
                              color: Color(0x99FFFFFF),
                              fontSize: 10,
                              height: 1.2,
                              fontWeight: FontWeight.w600,
                              letterSpacing: 1.65,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),
                  const Spacer(flex: 5),
                  AnimatedSwitcher(
                    duration: const Duration(milliseconds: 250),
                    child: widget.startupFailed
                        ? const _StartupError(key: ValueKey('startup-error'))
                        : _MomentumLoader(
                            key: const ValueKey('startup-loader'),
                            animation: _pulseController,
                          ),
                  ),
                  const SizedBox(height: 30),
                ],
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MomentumLoader extends StatelessWidget {
  const _MomentumLoader({required this.animation, super.key});

  final Animation<double> animation;

  @override
  Widget build(BuildContext context) {
    return Semantics(
      label: 'Starting Momentum',
      child: SizedBox(
        width: 112,
        height: 3,
        child: ClipRRect(
          borderRadius: BorderRadius.circular(99),
          child: ColoredBox(
            color: const Color(0x14FFFFFF),
            child: AnimatedBuilder(
              animation: animation,
              builder: (context, child) {
                final position = math.sin(animation.value * math.pi);
                return Align(
                  alignment: Alignment(position * 2 - 1, 0),
                  child: child,
                );
              },
              child: Container(
                width: 40,
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(99),
                  gradient: const LinearGradient(
                    colors: [
                      Color(0x00FF3131),
                      MomentumSplashScreen.brandRed,
                      Color(0x00FF3131),
                    ],
                  ),
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}

class _StartupError extends StatelessWidget {
  const _StartupError({super.key});

  @override
  Widget build(BuildContext context) {
    return const Text(
      'STARTUP PAUSED · PLEASE REOPEN THE APP',
      textAlign: TextAlign.center,
      style: TextStyle(
        color: Color(0xB3FFFFFF),
        fontSize: 10,
        fontWeight: FontWeight.w600,
        letterSpacing: 1.2,
      ),
    );
  }
}

class _AmbientGlow extends StatelessWidget {
  const _AmbientGlow({required this.size, required this.color});

  final double size;
  final Color color;

  @override
  Widget build(BuildContext context) {
    return IgnorePointer(
      child: Container(
        width: size,
        height: size,
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          gradient: RadialGradient(
            colors: [color, color.withValues(alpha: 0)],
          ),
        ),
      ),
    );
  }
}

class _GridPainter extends CustomPainter {
  const _GridPainter();

  @override
  void paint(Canvas canvas, Size size) {
    final linePaint = Paint()
      ..color = const Color(0x0AFFFFFF)
      ..strokeWidth = 1;
    const spacing = 54.0;
    for (var x = -size.height; x < size.width; x += spacing) {
      canvas.drawLine(
        Offset(x, 0),
        Offset(x + size.height * 0.5, size.height),
        linePaint,
      );
    }

    final accentPaint = Paint()
      ..shader = const LinearGradient(
        colors: [Color(0x00FF3131), Color(0x38FF3131), Color(0x00FF3131)],
      ).createShader(Rect.fromLTWH(0, 0, size.width, size.height))
      ..strokeWidth = 1.2;
    canvas.drawLine(
      Offset(0, size.height * 0.7),
      Offset(size.width, size.height * 0.28),
      accentPaint,
    );
  }

  @override
  bool shouldRepaint(_GridPainter oldDelegate) => false;
}
