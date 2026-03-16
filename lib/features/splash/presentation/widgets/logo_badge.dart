import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class LogoBadge extends StatelessWidget {
  final IconData icon;
  final String? assetPath;
  final double iconScale;
  final double iconTwist;

  const LogoBadge({
    super.key,
    required this.icon,
    this.assetPath,
    required this.iconScale,
    required this.iconTwist,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 136,
      height: 136,
      decoration: BoxDecoration(
        gradient: const LinearGradient(
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
          colors: [AppColors.primary, AppColors.primaryVariant],
          stops: [0.0, 1.0],
        ),
        borderRadius: BorderRadius.circular(40),
        boxShadow: [
          BoxShadow(
            color: AppColors.primary.withOpacity(0.50),
            blurRadius: 40,
            spreadRadius: -4,
            offset: const Offset(0, 20),
          ),
          BoxShadow(
            color: AppColors.secondary.withOpacity(0.28),
            blurRadius: 24,
            spreadRadius: -6,
            offset: const Offset(-6, -6),
          ),
        ],
      ),
      child: Stack(
        alignment: Alignment.center,
        children: [
          Positioned.fill(
            child: Container(
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(40),
                gradient: LinearGradient(
                  begin: Alignment.topLeft,
                  end: Alignment.bottomRight,
                  colors: [Colors.white.withOpacity(0.18), Colors.transparent],
                ),
              ),
            ),
          ),
          Transform.scale(
            scale: iconScale,
            child: Transform.rotate(
              angle: iconTwist,
              child: assetPath != null
                  ? Image.asset(assetPath!, width: 74, height: 74)
                  : Icon(icon, size: 74, color: AppColors.onPrimary),
            ),
          ),
        ],
      ),
    );
  }
}
