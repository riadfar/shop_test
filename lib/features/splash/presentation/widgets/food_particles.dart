import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'food_icons.dart';

class ParticleDef {
  final IconData icon;
  final double x, y, size, angle;

  const ParticleDef({
    required this.icon,
    required this.x,
    required this.y,
    required this.size,
    required this.angle,
  });
}

class FoodParticles extends StatelessWidget {
  final double progress;

  const FoodParticles({super.key, required this.progress});

  @override
  Widget build(BuildContext context) {
    if (progress == 0.0) return const SizedBox.shrink();

    return LayoutBuilder(builder: (context, constraints) {
      return Stack(
        children: foodIcons.map((p) {
          final opacity = (progress * 1.6).clamp(0.0, 1.0) * 0.16;
          return Positioned(
            left: p.x * constraints.maxWidth - p.size,
            top: p.y * constraints.maxHeight - p.size,
            child: Transform.scale(
              scale: progress,
              child: Transform.rotate(
                angle: p.angle,
                child: Opacity(
                  opacity: opacity,
                  child: Icon(p.icon,
                      size: p.size * 2.2, color: AppColors.primary),
                ),
              ),
            ),
          );
        }).toList(),
      );
    });
  }
}
