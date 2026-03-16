import 'package:flutter/material.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class CartScreen extends StatelessWidget {
  const CartScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: Center(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(Icons.shopping_bag_rounded, size: 72, color: AppColors.primary.withValues(alpha: 0.4)),
            const SizedBox(height: 16),
            Text(context.tr('cart_placeholder'),
              style: AppTextStyles.textTheme.titleMedium?.copyWith(color: onSurface.withValues(alpha: 0.6))),
          ],
        ),
      ),
    );
  }
}
