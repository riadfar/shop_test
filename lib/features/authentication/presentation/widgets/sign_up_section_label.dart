import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SignUpSectionLabel extends StatelessWidget {
  final String label;
  final IconData icon;
  const SignUpSectionLabel({super.key, required this.label, required this.icon});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Row(
      children: [
        Icon(icon, color: AppColors.primary, size: 16),
        const SizedBox(width: 7),
        Text(
          label,
          style: AppTextStyles.textTheme.labelLarge?.copyWith(
            color: onSurface.withOpacity(0.75),
            fontWeight: FontWeight.w700,
            letterSpacing: 0.6,
            fontSize: 12,
          ),
        ),
        const SizedBox(width: 10),
        Expanded(
          child: Divider(
            color: isDark ? AppColors.borderDark : AppColors.borderLight,
            thickness: 1,
          ),
        ),
      ],
    );
  }
}
