import 'package:flutter/material.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_decorations.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../domain/entities/shop.dart';

class ShopMetadataGrid extends StatelessWidget {
  final Shop shop;

  const ShopMetadataGrid({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final numeric = shop.estimatedDeliveryTime
        .replaceAll(RegExp(r'[^0-9\-–]'), '')
        .trim();
    final etaLabel =
        '${numeric.isEmpty ? shop.estimatedDeliveryTime : numeric}'
        '${context.tr('delivery_time_suffix')}';
    final minOrder =
        '${shop.minimumOrderAmount.toStringAsFixed(0)} ${context.tr('currency_symbol')}';
    final feeLabel = shop.deliveryFee > 0
        ? '${shop.deliveryFee.toStringAsFixed(0)} ${context.tr('currency_symbol')}'
        : context.tr('free_delivery');

    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 0),
      child: Row(
        children: [
          _MetaTile(
            icon: Icons.schedule_outlined,
            value: etaLabel,
            label: context.tr('eta'),
          ),
          const SizedBox(width: 12),
          _MetaTile(
            icon: Icons.shopping_bag_outlined,
            value: minOrder,
            label: context.tr('min_order'),
          ),
          const SizedBox(width: 12),
          _MetaTile(
            icon: Icons.delivery_dining_outlined,
            value: feeLabel,
            label: context.tr('delivery_fee'),
          ),
        ],
      ),
    );
  }
}

class _MetaTile extends StatelessWidget {
  final IconData icon;
  final String value;
  final String label;

  const _MetaTile({
    required this.icon,
    required this.value,
    required this.label,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface =
        isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Expanded(
      child: Container(
        padding:
            const EdgeInsets.symmetric(vertical: 14, horizontal: 8),
        decoration: isDark
            ? AppDecorations.cardDecorationDark
            : AppDecorations.cardDecorationLight,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Icon(icon, size: 22, color: AppColors.primary),
            const SizedBox(height: 6),
            Text(
              value,
              style: AppTextStyles.textTheme.titleSmall?.copyWith(
                  fontWeight: FontWeight.w700, color: onSurface),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
            const SizedBox(height: 2),
            Text(
              label,
              style: AppTextStyles.textTheme.bodySmall
                  ?.copyWith(color: AppColors.iconLight),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ],
        ),
      ),
    );
  }
}