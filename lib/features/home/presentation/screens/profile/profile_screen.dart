import 'package:flutter/material.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../core/theme/app_text_styles.dart';
import '../settings/settings_screen.dart';
import 'widgets/edit_profile_sheet.dart';
import 'widgets/profile_header.dart';
import 'widgets/profile_info_card.dart';

class ProfileScreen extends StatefulWidget {
  const ProfileScreen({super.key});
  @override State<ProfileScreen> createState() => _ProfileScreenState();
}

class _ProfileScreenState extends State<ProfileScreen> {
  String _name  = 'Alex Johnson';
  String _email = 'alex@flavorRush.com';
  String _phone = '+1 (555) 123-4567';

  void _openEdit() {
    showModalBottomSheet(
      context: context, isScrollControlled: true,
      shape: const RoundedRectangleBorder(borderRadius: BorderRadius.vertical(top: Radius.circular(24))),
      builder: (_) => EditProfileSheet(
        initialName: _name, initialEmail: _email, initialPhone: _phone,
        onSave: (n, e, p) {
          setState(() { _name = n; _email = e; _phone = p; });
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(context.tr('profile_updated')), backgroundColor: AppColors.primary,
          ));
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final isAr      = Localizations.localeOf(context).languageCode == 'ar';
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SingleChildScrollView(
        child: Column(children: [
          const ProfileHeader(),
          const SizedBox(height: 56),
          Text(_name, style: AppTextStyles.textTheme.titleLarge?.copyWith(fontWeight: FontWeight.w800, color: onSurface)),
          const SizedBox(height: 4),
          Text(context.tr('member_since'), style: AppTextStyles.textTheme.bodySmall?.copyWith(color: AppColors.iconLight)),
          const SizedBox(height: 24),
          ProfileInfoCard(name: _name, email: _email, phone: _phone, onEdit: _openEdit),
          const SizedBox(height: 14),
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: InkWell(
              onTap: () => Navigator.push(context, MaterialPageRoute(builder: (_) => const SettingsScreen())),
              borderRadius: BorderRadius.circular(16),
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 16),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(16),
                  color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                  boxShadow: [BoxShadow(color: isDark ? AppColors.shadowDark : AppColors.shadowLight, blurRadius: 8, offset: const Offset(0, 2))],
                ),
                child: Row(children: [
                  Container(width: 38, height: 38,
                    decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(11)),
                    child: const Icon(Icons.settings_rounded, color: AppColors.primary, size: 18)),
                  const SizedBox(width: 12),
                  Expanded(child: Text(context.tr('settings'), style: AppTextStyles.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: onSurface))),
                  Icon(isAr ? Icons.chevron_left_rounded : Icons.chevron_right_rounded, color: AppColors.iconLight, size: 20),
                ]),
              ),
            ),
          ),
          const SizedBox(height: 40),
        ]),
      ),
    );
  }
}
