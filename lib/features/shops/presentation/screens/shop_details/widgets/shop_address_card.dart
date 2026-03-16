import 'package:flutter/material.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_decorations.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../domain/entities/shop.dart';

class ShopAddressCard extends StatelessWidget {
  final Shop shop;

  const ShopAddressCard({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface =
        isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    final fullAddress = [shop.street, shop.state, shop.city, shop.country]
        .where((s) => s.isNotEmpty)
        .join(', ');

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Container(
        padding: const EdgeInsets.all(16),
        decoration: isDark
            ? AppDecorations.cardDecorationDark
            : AppDecorations.cardDecorationLight,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Row(children: [
              const Icon(Icons.location_on_rounded,
                  color: AppColors.primary, size: 18),
              const SizedBox(width: 8),
              Text(context.tr('address'),
                  style: AppTextStyles.textTheme.titleSmall?.copyWith(
                      fontWeight: FontWeight.w700, color: onSurface)),
            ]),
            if (fullAddress.isNotEmpty) ...[
              const SizedBox(height: 8),
              Text(fullAddress,
                  style: AppTextStyles.textTheme.bodyMedium
                      ?.copyWith(color: AppColors.iconLight, height: 1.5)),
            ],
            if (shop.otherDetails.isNotEmpty) ...[
              const SizedBox(height: 4),
              Text(shop.otherDetails,
                  style: AppTextStyles.textTheme.bodySmall
                      ?.copyWith(color: AppColors.iconLight)),
            ],
            if (shop.deliveryRegions.isNotEmpty) ...[
              const Divider(height: 24, color: AppColors.borderLight),
              Row(children: [
                const Icon(Icons.map_outlined,
                    color: AppColors.primary, size: 18),
                const SizedBox(width: 8),
                Text(context.tr('delivery_regions'),
                    style: AppTextStyles.textTheme.titleSmall?.copyWith(
                        fontWeight: FontWeight.w700, color: onSurface)),
              ]),
              const SizedBox(height: 10),
              Wrap(
                spacing: 8,
                runSpacing: 8,
                children: shop.deliveryRegions
                    .map((r) => _RegionChip(label: r))
                    .toList(),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class _RegionChip extends StatelessWidget {
  final String label;

  const _RegionChip({required this.label});

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
      decoration: BoxDecoration(
        color: AppColors.primary.withValues(alpha: 0.08),
        borderRadius: BorderRadius.circular(20),
        border:
            Border.all(color: AppColors.primary.withValues(alpha: 0.25)),
      ),
      child: Text(label,
          style: const TextStyle(
              fontSize: 12,
              fontWeight: FontWeight.w500,
              color: AppColors.primary)),
    );
  }
}