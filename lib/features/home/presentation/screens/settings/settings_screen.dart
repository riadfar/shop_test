import 'package:flutter/material.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import 'widgets/change_password_sheet.dart';
import 'widgets/font_size_card.dart';
import 'widgets/settings_section.dart';
import 'widgets/settings_tile.dart';
import 'widgets/theme_lang_card.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  void _showPasswordSheet(BuildContext ctx) => showModalBottomSheet(
    context: ctx, isScrollControlled: true,
    shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
    builder: (_) => const ChangePasswordSheet(),
  );

  void _showLogout(BuildContext ctx) => showDialog(
    context: ctx,
    builder: (c) => AlertDialog(
      title: Text(ctx.tr('logout')),
      content: Text(ctx.tr('logout_confirm')),
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(18)),
      actions: [
        TextButton(onPressed: () => Navigator.pop(c), child: Text(ctx.tr('cancel'))),
        TextButton(
          onPressed: () { Navigator.pop(c); Navigator.of(ctx).pushNamedAndRemoveUntil('/login', (_) => false); },
          child: Text(ctx.tr('logout'), style: const TextStyle(color: AppColors.error, fontWeight: FontWeight.w700))),
      ],
    ),
  );

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      appBar: AppBar(title: Text(context.tr('settings')), centerTitle: true),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
          SettingsSection(title: context.tr('preferences'), children: const [
            ThemeLangToggles(),
            FontSizeCard(),
          ]),
          const SizedBox(height: 22),
          SettingsSection(title: context.tr('security_section'), children: [
            SettingsTile(
              icon: Icons.lock_outline_rounded, title: context.tr('change_password'),
              trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.iconLight, size: 20),
              onTap: () => _showPasswordSheet(context)),
          ]),
          const SizedBox(height: 22),
          SettingsSection(title: context.tr('about_section'), children: [
            SettingsTile(icon: Icons.privacy_tip_outlined, title: context.tr('privacy_policy'),
              trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.iconLight, size: 20), onTap: () {}),
            SettingsTile(icon: Icons.description_outlined, title: context.tr('terms_conditions'),
              trailing: const Icon(Icons.chevron_right_rounded, color: AppColors.iconLight, size: 20), onTap: () {}),
            SettingsTile(icon: Icons.info_outline_rounded, title: context.tr('app_version'), subtitle: '1.0.0'),
          ]),
          const SizedBox(height: 22),
          SettingsSection(title: '', children: [
            SettingsTile(icon: Icons.logout_rounded, title: context.tr('logout'),
              isDestructive: true, onTap: () => _showLogout(context)),
          ]),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
