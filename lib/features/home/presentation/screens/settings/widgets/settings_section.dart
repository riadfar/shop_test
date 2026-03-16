import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_decorations.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class SettingsSection extends StatelessWidget {
  final String title;
  final List<Widget> children;
  const SettingsSection({super.key, required this.title, required this.children});

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20),
      child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        if (title.isNotEmpty)
          Padding(
            padding: const EdgeInsets.only(left: 4, bottom: 10),
            child: Text(title.toUpperCase(), style: AppTextStyles.textTheme.labelSmall?.copyWith(
              color: onSurface.withValues(alpha: 0.45), letterSpacing: 1.0)),
          ),
        Container(
          decoration: (isDark ? AppDecorations.cardDecorationDark : AppDecorations.cardDecorationLight)
              .copyWith(borderRadius: BorderRadius.circular(20)),
          child: Column(children: _separated(children, isDark)),
        ),
      ]),
    );
  }

  List<Widget> _separated(List<Widget> items, bool isDark) {
    final result = <Widget>[];
    for (int i = 0; i < items.length; i++) {
      result.add(items[i]);
      if (i < items.length - 1) {
        result.add(Divider(height: 1, indent: 72, endIndent: 16,
          color: isDark ? AppColors.borderDark : AppColors.borderLight));
      }
    }
    return result;
  }
}
