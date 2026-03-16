import 'package:flutter/material.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../domain/entities/shop.dart';

class ShopMainInfo extends StatelessWidget {
  final Shop shop;

  const ShopMainInfo({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface =
        isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    final lang = Localizations.localeOf(context).languageCode;
    final name = lang == 'ar' ? shop.nameAr : shop.nameEn;
    final desc = lang == 'ar' ? shop.descriptionAr : shop.descriptionEn;

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Expanded(
                child: Text(
                  name,
                  style: AppTextStyles.textTheme.titleLarge?.copyWith(
                      fontWeight: FontWeight.w800,
                      color: onSurface,
                      letterSpacing: -0.5),
                ),
              ),
              const SizedBox(width: 8),
              _AvailabilityBadge(isOpen: shop.availability),
            ],
          ),
          if (desc.isNotEmpty) ...[
            const SizedBox(height: 8),
            Text(
              desc,
              style: AppTextStyles.textTheme.bodyMedium
                  ?.copyWith(color: AppColors.iconLight, height: 1.5),
              maxLines: 3,
              overflow: TextOverflow.ellipsis,
            ),
          ],
          if (shop.categoryType.isNotEmpty || shop.badgeTag.isNotEmpty) ...[
            const SizedBox(height: 12),
            Wrap(
              spacing: 8,
              runSpacing: 6,
              children: [
                if (shop.categoryType.isNotEmpty)
                  _Chip(label: shop.categoryType, isPrimary: true),
                if (shop.badgeTag.isNotEmpty)
                  _Chip(label: shop.badgeTag, isPrimary: false),
              ],
            ),
          ],
        ],
      ),
    );
  }
}

class _AvailabilityBadge extends StatelessWidget {
  final bool isOpen;

  const _AvailabilityBadge({required this.isOpen});

  @override
  Widget build(BuildContext context) {
    final color = isOpen ? AppColors.success : AppColors.error;
    final label =
        isOpen ? context.tr('shop_open') : context.tr('shop_closed');
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.12),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.4)),
      ),
      child: Row(mainAxisSize: MainAxisSize.min, children: [
        Container(
            width: 6,
            height: 6,
            decoration:
                BoxDecoration(shape: BoxShape.circle, color: color)),
        const SizedBox(width: 5),
        Text(label,
            style: TextStyle(
                fontSize: 12, fontWeight: FontWeight.w600, color: color)),
      ]),
    );
  }
}

class _Chip extends StatelessWidget {
  final String label;
  final bool isPrimary;

  const _Chip({required this.label, required this.isPrimary});

  @override
  Widget build(BuildContext context) {
    final color = isPrimary ? AppColors.primary : AppColors.secondary;
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
      decoration: BoxDecoration(
        color: color.withValues(alpha: 0.09),
        borderRadius: BorderRadius.circular(20),
        border: Border.all(color: color.withValues(alpha: 0.3)),
      ),
      child: Text(label,
          style: TextStyle(
              fontSize: 12, fontWeight: FontWeight.w600, color: color)),
    );
  }
}