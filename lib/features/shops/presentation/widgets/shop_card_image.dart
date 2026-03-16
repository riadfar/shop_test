import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';

import '../../../../core/theme/app_colors.dart';
import 'shop_status_badge.dart';

/// Cover image section with a dark gradient overlay, shop name, and status badge.
class ShopCardImage extends StatelessWidget {
  final String coverPhotoUrl;
  final String shopName;
  final bool isOpen;

  const ShopCardImage({
    super.key,
    required this.coverPhotoUrl,
    required this.shopName,
    required this.isOpen,
  });

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      child: Stack(
        fit: StackFit.expand,
        children: [
          coverPhotoUrl.isNotEmpty
              ? CachedNetworkImage(
                  imageUrl: coverPhotoUrl,
                  fit: BoxFit.cover,
                  placeholder: (_, __) =>
                      const ColoredBox(color: AppColors.borderLight),
                  errorWidget: (_, __, ___) => const _FallbackCover(),
                )
              : const _FallbackCover(),

          // Gradient — makes name readable and adds depth
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

          // Shop name on gradient
          Positioned(
            bottom: 10,
            left: 12,
            right: 70,
            child: Text(
              shopName,
              style: Theme.of(context).textTheme.titleSmall?.copyWith(
                    color: Colors.white,
                    fontWeight: FontWeight.w700,
                    shadows: [
                      const Shadow(blurRadius: 4, color: Colors.black38),
                    ],
                  ),
              maxLines: 1,
              overflow: TextOverflow.ellipsis,
            ),
          ),

          // Status badge — floating top-right
          Positioned(
            top: 10,
            right: 10,
            child: ShopStatusBadge(isOpen: isOpen),
          ),
        ],
      ),
    );
  }
}

class _FallbackCover extends StatelessWidget {
  const _FallbackCover();

  @override
  Widget build(BuildContext context) => const ColoredBox(
        color: AppColors.borderLight,
        child: Center(
          child: Icon(
            Icons.storefront_outlined,
            size: 52,
            color: AppColors.iconLight,
          ),
        ),
      );
}
