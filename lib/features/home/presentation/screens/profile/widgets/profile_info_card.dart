import 'package:flutter/material.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_decorations.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class ProfileInfoCard extends StatelessWidget {
  final String name, email, phone;
  final VoidCallback onEdit;
  const ProfileInfoCard({super.key, required this.name, required this.email, required this.phone, required this.onEdit});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 20),
      padding: const EdgeInsets.fromLTRB(20, 20, 20, 20),
      decoration: (isDark ? AppDecorations.cardDecorationDark : AppDecorations.cardDecorationLight)
          .copyWith(borderRadius: BorderRadius.circular(22)),
      child: Column(
        children: [
          _InfoRow(icon: Icons.person_outline_rounded, label: context.tr('full_name'), value: name),
          Divider(height: 22, color: isDark ? AppColors.borderDark : AppColors.borderLight),
          _InfoRow(icon: Icons.email_outlined, label: context.tr('email_address'), value: email),
          Divider(height: 22, color: isDark ? AppColors.borderDark : AppColors.borderLight),
          _InfoRow(icon: Icons.phone_outlined, label: context.tr('phone_number'), value: phone),
          const SizedBox(height: 20),
          SizedBox(
            width: double.infinity,
            child: ElevatedButton.icon(
              onPressed: onEdit,
              icon: const Icon(Icons.edit_rounded, size: 17),
              label: Text(context.tr('edit_profile')),
              style: ElevatedButton.styleFrom(
                backgroundColor: AppColors.primary, foregroundColor: AppColors.onPrimary,
                padding: const EdgeInsets.symmetric(vertical: 14),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(14)),
                elevation: 0,
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _InfoRow extends StatelessWidget {
  final IconData icon;
  final String label, value;
  const _InfoRow({required this.icon, required this.label, required this.value});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Row(children: [
      Container(width: 38, height: 38,
        decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(11)),
        child: Icon(icon, color: AppColors.primary, size: 18)),
      const SizedBox(width: 12),
      Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
        Text(label, style: AppTextStyles.textTheme.bodySmall?.copyWith(color: onSurface.withValues(alpha: 0.50))),
        const SizedBox(height: 2),
        Text(value, style: AppTextStyles.textTheme.bodyMedium?.copyWith(color: onSurface, fontWeight: FontWeight.w600)),
      ])),
    ]);
  }
}
