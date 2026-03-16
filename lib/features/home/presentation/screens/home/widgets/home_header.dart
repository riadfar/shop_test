import 'package:flutter/material.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class HomeHeader extends StatelessWidget {
  const HomeHeader({super.key});

  String _greeting(BuildContext context) {
    final h = DateTime.now().hour;
    if (h < 12) return context.tr('home_greeting_morning');
    if (h < 17) return context.tr('home_greeting_afternoon');
    return context.tr('home_greeting_evening');
  }

  @override
  Widget build(BuildContext context) {
    final isAr  = Localizations.localeOf(context).languageCode == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        children: [
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(_greeting(context),
                  style: AppTextStyles.textTheme.bodySmall?.copyWith(
                    color: onSurface.withValues(alpha: 0.55), fontWeight: FontWeight.w500)),
                const SizedBox(height: 2),
                Text(isAr ? 'مرحباً! 👋' : 'Hello! 👋',
                  style: AppTextStyles.textTheme.headlineSmall?.copyWith(
                    color: onSurface, fontWeight: FontWeight.w800, letterSpacing: -0.5)),
                const SizedBox(height: 6),
                Row(
                  children: [
                    Icon(Icons.location_on_rounded, color: AppColors.primary, size: 15),
                    const SizedBox(width: 3),
                    Text(isAr ? 'نيويورك، أمريكا' : 'New York, USA',
                      style: AppTextStyles.textTheme.bodySmall?.copyWith(
                        color: onSurface, fontWeight: FontWeight.w600)),
                    const SizedBox(width: 2),
                    Icon(Icons.keyboard_arrow_down_rounded, size: 16, color: AppColors.primary),
                  ],
                ),
              ],
            ),
          ),
          Container(
            width: 44, height: 44,
            decoration: BoxDecoration(
              color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
              borderRadius: BorderRadius.circular(14),
              boxShadow: [BoxShadow(color: isDark ? AppColors.shadowDark : AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, 2))],
            ),
            child: Stack(
              alignment: Alignment.center,
              children: [
                Icon(Icons.notifications_outlined, color: onSurface, size: 22),
                PositionedDirectional(
                  end: 9, top: 9,
                  child: Container(width: 8, height: 8, decoration: const BoxDecoration(color: AppColors.primary, shape: BoxShape.circle)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
