import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../domain/entities/shop.dart';

class ShopCoverSliver extends StatelessWidget {
  final Shop shop;

  const ShopCoverSliver({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return SliverAppBar(
      expandedHeight: 264,
      pinned: true,
      stretch: true,
      backgroundColor:
          isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
      leading: Padding(
        padding: const EdgeInsets.all(8),
        child: GestureDetector(
          onTap: () => Navigator.pop(context),
          child: Container(
            decoration: BoxDecoration(
              color: Colors.black26,
              borderRadius: BorderRadius.circular(10),
            ),
            child: Icon(
              isAr
                  ? Icons.arrow_forward_ios_rounded
                  : Icons.arrow_back_ios_rounded,
              color: Colors.white,
              size: 18,
            ),
          ),
        ),
      ),
      flexibleSpace: FlexibleSpaceBar(
        stretchModes: const [StretchMode.zoomBackground],
        background: Stack(
          fit: StackFit.expand,
          children: [
            shop.coverPhoto.isNotEmpty
                ? CachedNetworkImage(
                    imageUrl: shop.coverPhoto,
                    fit: BoxFit.cover,
                    placeholder: (_, __) =>
                        const ColoredBox(color: AppColors.borderLight),
                    errorWidget: (_, __, ___) =>
                        const ColoredBox(color: AppColors.borderLight),
                  )
                : const ColoredBox(color: AppColors.borderLight),
            const DecoratedBox(
              decoration: BoxDecoration(
                gradient: LinearGradient(
                  begin: Alignment.topCenter,
                  end: Alignment.bottomCenter,
                  stops: [0.35, 1.0],
                  colors: [Colors.transparent, Colors.black54],
                ),
              ),
            ),
            if (shop.profilePhoto.isNotEmpty)
              Positioned(
                bottom: 0,
                left: 0,
                right: 0,
                child: Center(
                  child: Container(
                    width: 88,
                    height: 88,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      border: Border.all(color: Colors.white, width: 3),
                      boxShadow: const [
                        BoxShadow(
                            color: Colors.black26,
                            blurRadius: 12,
                            offset: Offset(0, 4))
                      ],
                      image: DecorationImage(
                        image:
                            CachedNetworkImageProvider(shop.profilePhoto),
                        fit: BoxFit.cover,
                      ),
                    ),
                  ),
                ),
              ),
            if (!shop.availability)
              Positioned.fill(
                child: ColoredBox(
                  color: Colors.black38,
                  child: Center(
                    child: Container(
                      padding: const EdgeInsets.symmetric(
                          horizontal: 20, vertical: 10),
                      decoration: BoxDecoration(
                        color: AppColors.error,
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: Text(context.tr('shop_closed'),
                          style: const TextStyle(
                              color: Colors.white,
                              fontSize: 18,
                              fontWeight: FontWeight.w800)),
                    ),
                  ),
                ),
              ),
          ],
        ),
      ),
    );
  }
}