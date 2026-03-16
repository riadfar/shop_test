import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SignUpHeader extends StatelessWidget {
  final bool isDark;
  const SignUpHeader({super.key, required this.isDark});

  @override
  Widget build(BuildContext context) {
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            color: AppColors.primary.withOpacity(0.10),
            borderRadius: BorderRadius.circular(20),
          ),
          child: const Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Icon(Icons.local_fire_department_rounded,
                  color: AppColors.primary, size: 14),
              SizedBox(width: 5),
              Text(
                'FlavorRush',
                style: TextStyle(
                  color: AppColors.primary,
                  fontSize: 12,
                  fontWeight: FontWeight.w700,
                  letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
        const SizedBox(height: 14),
        Text(
          context.tr('join_us'),
          style: AppTextStyles.textTheme.headlineMedium?.copyWith(
            color: onSurface,
            fontWeight: FontWeight.w800,
            letterSpacing: -0.6,
            height: 1.15,
          ),
        ),
        const SizedBox(height: 8),
        Text(
          context.tr('join_subtitle'),
          style: AppTextStyles.textTheme.bodyMedium?.copyWith(
            color: onSurface.withOpacity(0.58),
            height: 1.55,
          ),
        ),
      ],
    );
  }
}
