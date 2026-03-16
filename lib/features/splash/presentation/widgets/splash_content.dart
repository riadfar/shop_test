import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';
import 'logo_badge.dart';
import 'pulsing_dots.dart';
import 'splash_animations.dart';

class SplashContent extends StatelessWidget {
  final SplashAnimations anims;
  final String appName;
  final String appTagline;
  final IconData appLogoIcon;
  final String? appLogoAsset;
  final bool isDark;

  const SplashContent({
    super.key,
    required this.anims,
    required this.appName,
    required this.appTagline,
    required this.appLogoIcon,
    this.appLogoAsset,
    required this.isDark,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final textColor =
        isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;

    return Center(
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Opacity(
            opacity: anims.containerOpacity.value.clamp(0.0, 1.0),
            child: Transform.scale(
              scale: anims.containerScale.value.clamp(0.0, 2.0),
              child: LogoBadge(
                icon: appLogoIcon,
                assetPath: appLogoAsset,
                iconScale: anims.iconScale.value.clamp(0.0, 2.0),
                iconTwist: anims.iconRotation.value,
              ),
            ),
          ),
          const SizedBox(height: 36),
          ClipRect(
            child: SlideTransition(
              position: anims.nameSlide,
              child: FadeTransition(
                opacity: anims.nameFade,
                child: Text(appName,
                    style: textTheme.displaySmall?.copyWith(
                        color: AppColors.primary,
                        fontWeight: FontWeight.w900,
                        letterSpacing: -1.0,
                        height: 1.0)),
              ),
            ),
          ),
          const SizedBox(height: 10),
          FadeTransition(
            opacity: anims.taglineFade,
            child: Text(appTagline,
                style: textTheme.bodyMedium?.copyWith(
                    color: textColor.withOpacity(0.55), letterSpacing: 0.4)),
          ),
          const SizedBox(height: 72),
          FadeTransition(
            opacity: anims.taglineFade,
            child: PulsingDots(
                loopAnimation: anims.loaderCtrl,
                color: AppColors.primary,
                accentColor: AppColors.secondary),
          ),
        ],
      ),
    );
  }
}
