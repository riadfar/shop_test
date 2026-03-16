import 'dart:math' as math;
import 'package:flutter/material.dart';

class PulsingDots extends StatelessWidget {
  final Animation<double> loopAnimation;
  final Color color;
  final Color accentColor;

  const PulsingDots({
    super.key,
    required this.loopAnimation,
    required this.color,
    required this.accentColor,
  });

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: loopAnimation,
      builder: (context, _) {
        return Row(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: List.generate(3, (i) {
            final phase = (loopAnimation.value + i * (1.0 / 3.0)) % 1.0;
            final sineVal = math.sin(phase * math.pi);
            final dotColor = i == 1 ? accentColor : color;
            final scale = 0.55 + 0.45 * sineVal;
            final opacity = 0.28 + 0.72 * sineVal;
            final yShift = -6.0 * sineVal;

            return Transform.translate(
              offset: Offset(0, yShift),
              child: Transform.scale(
                scale: scale,
                child: Container(
                  margin: const EdgeInsets.symmetric(horizontal: 5),
                  width: 12,
                  height: 12,
                  decoration: BoxDecoration(
                    color: dotColor.withOpacity(opacity),
                    shape: BoxShape.circle,
                    boxShadow: [
                      BoxShadow(
                        color: dotColor.withOpacity(opacity * 0.5),
                        blurRadius: 8,
                        spreadRadius: -1,
                      ),
                    ],
                  ),
                ),
              ),
            );
          }),
        );
      },
    );
  }
}
