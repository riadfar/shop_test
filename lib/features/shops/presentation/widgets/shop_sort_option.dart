import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/sort_type.dart';

/// Returns the localized label for a [SortType] value.
String sortTypeLabel(BuildContext context, SortType type) => switch (type) {
      SortType.none => context.tr('sort_none'),
      SortType.eta => context.tr('sort_eta'),
      SortType.minimumOrder => context.tr('sort_min_order'),
      SortType.alphabetical => context.tr('sort_alphabetical'),
      SortType.deliveryFeeAsc => context.tr('sort_delivery_fee_asc'),
      SortType.deliveryFeeDesc => context.tr('sort_delivery_fee_desc'),
    };

class ShopSortOption extends StatelessWidget {
  final String label;
  final SortType value;
  final SortType groupValue;
  final ValueChanged<SortType> onChanged;

  const ShopSortOption({
    super.key,
    required this.label,
    required this.value,
    required this.groupValue,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    final selected = value == groupValue;
    return InkWell(
      onTap: () => onChanged(value),
      borderRadius: BorderRadius.circular(8),
      child: Padding(
        padding: const EdgeInsets.symmetric(vertical: 9, horizontal: 4),
        child: Row(
          children: [
            Container(
              width: 20,
              height: 20,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: selected ? AppColors.primary : AppColors.iconLight,
                  width: 2,
                ),
              ),
              child: selected
                  ? Center(
                      child: Container(
                        width: 10,
                        height: 10,
                        decoration: const BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.primary,
                        ),
                      ),
                    )
                  : null,
            ),
            const SizedBox(width: 10),
            Text(
              label,
              style: TextStyle(
                fontSize: 14,
                color: selected ? AppColors.primary : null,
              ),
            ),
          ],
        ),
      ),
    );
  }
}