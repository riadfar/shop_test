import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SplashBackground extends StatelessWidget {
  final double progress;
  final bool isDark;

  const SplashBackground({
    super.key,
    required this.progress,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    return Opacity(
      opacity: progress,
      child: Container(
        decoration: BoxDecoration(
          gradient: RadialGradient(
            center: const Alignment(0.0, -0.25),
            radius: 1.5,
            colors: isDark
                ? [
                    AppColors.primary.withOpacity(0.20),
                    AppColors.backgroundDark.withOpacity(0.95),
                    AppColors.backgroundDark,
                  ]
                : [
                    AppColors.secondary.withOpacity(0.14),
                    AppColors.primary.withOpacity(0.06),
                    AppColors.backgroundLight,
                  ],
            stops: const [0.0, 0.50, 1.0],
          ),
        ),
      ),
    );
  }
}
