import 'package:flutter/material.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_decorations.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/food_item_model.dart';

class FoodItemCard extends StatelessWidget {
  final FoodItemModel item;
  const FoodItemCard({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    final isAr  = Localizations.localeOf(context).languageCode == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: 172,
      margin: const EdgeInsetsDirectional.only(start: 4, end: 12),
      decoration: (isDark ? AppDecorations.cardDecorationDark : AppDecorations.cardDecorationLight)
          .copyWith(borderRadius: BorderRadius.circular(18)),
      clipBehavior: Clip.antiAlias,
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(
            height: 118,
            child: Stack(fit: StackFit.expand, children: [
              Image.asset(
                item.imagePath,
                fit: BoxFit.cover,
                errorBuilder: (_, __, ___) => const ColoredBox(color: Color(0xFFF0F0F0)),
              ),
              PositionedDirectional(end: 8, top: 8,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 3),
                  decoration: BoxDecoration(color: AppColors.primary, borderRadius: BorderRadius.circular(8)),
                  child: Text('\$${item.price.toStringAsFixed(2)}',
                    style: const TextStyle(color: AppColors.onPrimary, fontSize: 11, fontWeight: FontWeight.w700)),
                )),
            ]),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(10, 8, 10, 10),
            child: Column(crossAxisAlignment: CrossAxisAlignment.start, children: [
              Text(isAr ? item.nameAr : item.nameEn,
                style: AppTextStyles.textTheme.titleSmall?.copyWith(fontWeight: FontWeight.w700, fontSize: 13),
                maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 2),
              Text(isAr ? item.restaurantAr : item.restaurantEn,
                style: TextStyle(color: isDark ? AppColors.iconDark : AppColors.iconLight, fontSize: 11),
                maxLines: 1, overflow: TextOverflow.ellipsis),
              const SizedBox(height: 7),
              Row(children: [
                const Icon(Icons.star_rounded, size: 13, color: AppColors.secondary),
                const SizedBox(width: 2),
                Text('${item.rating}', style: const TextStyle(fontSize: 11, fontWeight: FontWeight.w600)),
                const Spacer(),
                const Icon(Icons.access_time_rounded, size: 11, color: AppColors.iconLight),
                const SizedBox(width: 2),
                Text('${item.deliveryMinutes}${context.tr('delivery_time_suffix')}',
                  style: const TextStyle(fontSize: 10, color: AppColors.iconLight)),
              ]),
              const SizedBox(height: 8),
              SizedBox(width: double.infinity, height: 30,
                child: ElevatedButton(
                  onPressed: () {},
                  style: ElevatedButton.styleFrom(
                    backgroundColor: AppColors.primary, foregroundColor: AppColors.onPrimary,
                    elevation: 0, shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(9)),
                    padding: EdgeInsets.zero, textStyle: const TextStyle(fontSize: 12, fontWeight: FontWeight.w600),
                  ),
                  child: Text(context.tr('add_to_cart')),
                )),
            ]),
          ),
        ],
      ),
    );
  }
}
