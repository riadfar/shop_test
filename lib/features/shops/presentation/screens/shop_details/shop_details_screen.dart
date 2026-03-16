import 'package:flutter/material.dart';

import '../../../../../core/theme/app_colors.dart';
import '../../../domain/entities/shop.dart';
import 'widgets/call_shop_button.dart';
import 'widgets/shop_address_card.dart';
import 'widgets/shop_cover_sliver.dart';
import 'widgets/shop_main_info.dart';
import 'widgets/shop_metadata_grid.dart';

class ShopDetailsScreen extends StatelessWidget {
  final Shop shop;

  const ShopDetailsScreen({super.key, required this.shop});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: CustomScrollView(
        physics: const BouncingScrollPhysics(),
        slivers: [
          ShopCoverSliver(shop: shop),
          SliverToBoxAdapter(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                // Space for the overlapping logo at the bottom of the cover
                const SizedBox(height: 52),
                ShopMainInfo(shop: shop),
                ShopMetadataGrid(shop: shop),
                ShopAddressCard(shop: shop),
                CallShopButton(contactInfo: shop.contactInfo),
              ],
            ),
          ),
        ],
      ),
    );
  }
}