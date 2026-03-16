import 'package:flutter/material.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';

class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [BoxShadow(color: isDark ? AppColors.shadowDark : AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, 2))],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            Icon(Icons.search_rounded, color: AppColors.iconLight, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: Text(context.tr('search_hint'),
                style: TextStyle(color: AppColors.iconLight, fontSize: 14, fontWeight: FontWeight.w400)),
            ),
            Container(
              width: 36, height: 36,
              margin: const EdgeInsets.only(right: 8),
              decoration: BoxDecoration(
                gradient: const LinearGradient(colors: [AppColors.primary, AppColors.primaryVariant]),
                borderRadius: BorderRadius.circular(10),
              ),
              child: const Icon(Icons.tune_rounded, color: AppColors.onPrimary, size: 18),
            ),
          ],
        ),
      ),
    );
  }
}
