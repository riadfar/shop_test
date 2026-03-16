import 'package:flutter/material.dart';
import '../../../../../../app/app.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/theme_manager.dart';
import 'settings_tile.dart';

class ThemeLangToggles extends StatelessWidget {
  const ThemeLangToggles({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr   = Localizations.localeOf(context).languageCode == 'ar';
    return Column(children: [
      SettingsTile(
        icon: isDark ? Icons.dark_mode_rounded : Icons.light_mode_rounded,
        title: context.tr('dark_mode'),
        trailing: Switch(
          value: isDark,
          onChanged: (v) => MyApp.setTheme(context, v ? AppTheme.dark : AppTheme.light),
          activeThumbColor: AppColors.primary,
        ),
      ),
      Divider(height: 1, indent: 72, endIndent: 16,
        color: isDark ? AppColors.borderDark : AppColors.borderLight),
      SettingsTile(
        icon: Icons.translate_rounded,
        title: context.tr('language_label'),
        subtitle: isAr ? 'العربية' : 'English',
        trailing: Switch(
          value: isAr,
          onChanged: (v) => MyApp.setLocale(context, v ? const Locale('ar') : const Locale('en', 'US')),
          activeThumbColor: AppColors.primary,
        ),
      ),
    ]);
  }
}
