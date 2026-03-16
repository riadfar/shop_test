import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/shop.dart';

/// Bottom row of the card showing location, ETA, and minimum order.
class ShopCardInfoRow extends StatelessWidget {
  final Shop shop;

  const ShopCardInfoRow({super.key, required this.shop});

  /// Strips the English "min" suffix from the API value and appends the
  /// localized time unit (e.g. " min" or " دقيقة").
  String _localizedEta(BuildContext context) {
    final numeric =
        shop.estimatedDeliveryTime.replaceAll(RegExp(r'[^0-9\-–]'), '').trim();
    final suffix = context.tr('delivery_time_suffix');
    return numeric.isEmpty ? shop.estimatedDeliveryTime : '$numeric$suffix';
  }

  @override
  Widget build(BuildContext context) {
    final minOrder =
        '${shop.minimumOrderAmount.toStringAsFixed(0)} ${context.tr('currency_symbol')}';

    return Row(
      children: [
        _InfoChip(icon: Icons.location_on_outlined, label: shop.city),
        const Spacer(),
        _InfoChip(
            icon: Icons.schedule_outlined, label: _localizedEta(context)),
        const Spacer(),
        _InfoChip(icon: Icons.shopping_bag_outlined, label: minOrder),
      ],
    );
  }
}

class _InfoChip extends StatelessWidget {
  final IconData icon;
  final String label;

  const _InfoChip({required this.icon, required this.label});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: [
        Icon(icon, size: 13, color: AppColors.iconLight),
        const SizedBox(width: 3),
        Text(
          label,
          style: Theme.of(context)
              .textTheme
              .labelSmall
              ?.copyWith(color: AppColors.iconLight),
        ),
      ],
    );
  }
}