import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class SettingsTile extends StatelessWidget {
  final IconData icon;
  final Color? iconColor;
  final String title;
  final String? subtitle;
  final Widget? trailing;
  final VoidCallback? onTap;
  final bool isDestructive;
  const SettingsTile({
    super.key, required this.icon, required this.title,
    this.iconColor, this.subtitle, this.trailing, this.onTap, this.isDestructive = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    final color     = isDestructive ? AppColors.error : (iconColor ?? AppColors.primary);
    return InkWell(
      onTap: onTap,
      borderRadius: BorderRadius.circular(18),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
        child: Row(children: [
          Container(width: 38, height: 38,
            decoration: BoxDecoration(color: color.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(11)),
            child: Icon(icon, color: color, size: 18)),
          const SizedBox(width: 14),
          Expanded(child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
            Text(title, style: AppTextStyles.textTheme.bodyMedium?.copyWith(
              fontWeight: FontWeight.w600, color: isDestructive ? AppColors.error : onSurface)),
            if (subtitle != null)
              Text(subtitle!, style: AppTextStyles.textTheme.bodySmall?.copyWith(color: onSurface.withValues(alpha: 0.50))),
          ])),
          if (trailing != null) trailing!,
        ]),
      ),
    );
  }
}
