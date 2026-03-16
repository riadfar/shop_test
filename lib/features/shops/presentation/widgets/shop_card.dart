import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_decorations.dart';
import '../../domain/entities/shop.dart';
import '../screens/shop_details/shop_details_screen.dart';
import 'shop_card_image.dart';
import 'shop_card_info_row.dart';

/// Premium tap-animated shop card. Compose ShopCardImage + details section.
class ShopCard extends StatefulWidget {
  final Shop shop;
  final VoidCallback? onTap;

  const ShopCard({super.key, required this.shop, this.onTap});

  @override
  State<ShopCard> createState() => _ShopCardState();
}

class _ShopCardState extends State<ShopCard> {
  double _scale = 1.0;

  void _onTapDown(TapDownDetails _) => setState(() => _scale = 0.97);
  void _onTapUp(TapUpDetails _) {
    setState(() => _scale = 1.0);
    if (widget.onTap != null) {
      widget.onTap!();
    } else {
      Navigator.push(
        context,
        MaterialPageRoute(
            builder: (_) => ShopDetailsScreen(shop: widget.shop)),
      );
    }
  }

  void _onTapCancel() => setState(() => _scale = 1.0);

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTapDown: _onTapDown,
      onTapUp: _onTapUp,
      onTapCancel: _onTapCancel,
      child: AnimatedScale(
        scale: _scale,
        duration: const Duration(milliseconds: 120),
        curve: Curves.easeOut,
        child: Container(
          decoration: isDark
              ? AppDecorations.cardDecorationDark
              : AppDecorations.cardDecorationLight,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(12),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ShopCardImage(
                  coverPhotoUrl: widget.shop.coverPhoto,
                  shopName: isAr ? widget.shop.nameAr : widget.shop.nameEn,
                  isOpen: widget.shop.availability,
                ),
                _ShopDetails(shop: widget.shop, isAr: isAr),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

class _ShopDetails extends StatelessWidget {
  final Shop shop;
  final bool isAr;

  const _ShopDetails({required this.shop, required this.isAr});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final borderColor =
        isDark ? AppColors.borderDark : AppColors.borderLight;
    return Padding(
      padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            isAr ? shop.descriptionAr : shop.descriptionEn,
            style: Theme.of(context)
                .textTheme
                .bodySmall
                ?.copyWith(
                    color: isDark ? AppColors.iconDark : AppColors.iconLight),
            maxLines: 2,
            overflow: TextOverflow.ellipsis,
          ),
          const SizedBox(height: 10),
          Divider(height: 1, thickness: 1, color: borderColor),
          const SizedBox(height: 10),
          ShopCardInfoRow(shop: shop),
        ],
      ),
    );
  }
}
