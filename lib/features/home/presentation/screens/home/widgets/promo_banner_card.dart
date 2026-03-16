import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/promo_banner_model.dart';

class PromoBannerCard extends StatelessWidget {
  final PromoBannerModel banner;
  const PromoBannerCard({super.key, required this.banner});

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Container(
      margin: const EdgeInsets.symmetric(horizontal: 4),
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: [banner.colorStart, banner.colorEnd],
          begin: Alignment.topLeft, end: Alignment.bottomRight,
        ),
        borderRadius: BorderRadius.circular(20),
      ),
      child: Stack(
        children: [
          PositionedDirectional(
            end: -10, top: -10,
            child: Icon(banner.icon, size: 110, color: AppColors.onPrimary.withValues(alpha: 0.12)),
          ),
          Padding(
            padding: const EdgeInsets.fromLTRB(22, 22, 80, 22),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text(isAr ? banner.titleAr : banner.titleEn,
                  style: AppTextStyles.textTheme.titleMedium?.copyWith(
                    color: AppColors.onPrimary, fontWeight: FontWeight.w800, height: 1.2)),
                const SizedBox(height: 6),
                Text(isAr ? banner.subtitleAr : banner.subtitleEn,
                  style: AppTextStyles.textTheme.bodySmall?.copyWith(
                    color: AppColors.onPrimary.withValues(alpha: 0.80))),
                const SizedBox(height: 14),
                Container(
                  padding: const EdgeInsets.symmetric(horizontal: 14, vertical: 6),
                  decoration: BoxDecoration(
                    color: AppColors.onPrimary.withValues(alpha: 0.22),
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: Text(isAr ? 'اطلب الآن' : 'Order Now',
                    style: const TextStyle(color: AppColors.onPrimary, fontSize: 12, fontWeight: FontWeight.w700)),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
