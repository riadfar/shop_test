import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'bottom_wave_clipper.dart';

class HeroSection extends StatelessWidget {
  final String appName;
  final String appSubtitle;
  final IconData appLogo;

  const HeroSection({
    super.key, required this.appName, required this.appSubtitle, required this.appLogo,
  });

  @override
  Widget build(BuildContext context) {
    return ClipPath(
      clipper: BottomWaveClipper(),
      child: Container(
        height: 290,
        decoration: const BoxDecoration(
          gradient: LinearGradient(
            begin: Alignment.topLeft, end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryVariant], stops: [0.0, 1.0],
          ),
        ),
        child: Stack(
          clipBehavior: Clip.none,
          children: [
            const _DecoCircle(right: -35, top: -35, radius: 120, opacity: 0.10),
            const _DecoCircle(right: 55, top: 55, radius: 58, opacity: 0.07),
            const _DecoCircle(left: -28, bottom: 55, radius: 90, opacity: 0.08),
            const _DecoCircle(left: 28, top: 30, radius: 42, opacity: 0.06),
            const _DecoCircle(left: 140, bottom: 80, radius: 30, opacity: 0.05),
            SafeArea(
              bottom: false,
              child: Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(height: 12),
                    Container(
                      width: 84, height: 84,
                      decoration: BoxDecoration(
                        color: AppColors.onPrimary.withOpacity(0.16),
                        borderRadius: BorderRadius.circular(26),
                        border: Border.all(color: AppColors.onPrimary.withOpacity(0.28), width: 1.5),
                      ),
                      child: Icon(appLogo, size: 46, color: AppColors.onPrimary),
                    ),
                    const SizedBox(height: 16),
                    Text(appName, style: const TextStyle(color: AppColors.onPrimary, fontSize: 28, fontWeight: FontWeight.w800, letterSpacing: -0.6, height: 1.1)),
                    const SizedBox(height: 5),
                    Text(appSubtitle, style: TextStyle(color: AppColors.onPrimary.withOpacity(0.72), fontSize: 13, fontWeight: FontWeight.w400, letterSpacing: 0.2)),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _DecoCircle extends StatelessWidget {
  final double radius, opacity;
  final double? left, right, top, bottom;

  const _DecoCircle({required this.radius, required this.opacity, this.left, this.right, this.top, this.bottom});

  @override
  Widget build(BuildContext context) {
    return Positioned(
      left: left, right: right, top: top, bottom: bottom,
      child: Container(
        width: radius * 2, height: radius * 2,
        decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.onPrimary.withOpacity(opacity)),
      ),
    );
  }
}