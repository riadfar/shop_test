import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../../../../core/theme/app_colors.dart';

/// Skeleton card that exactly mirrors the shape of ShopCard.
/// Displayed in a list during the ShopLoading state.
class ShopCardShimmer extends StatelessWidget {
  const ShopCardShimmer({super.key});

  @override
  Widget build(BuildContext context) {
    return Shimmer.fromColors(
      baseColor: AppColors.borderLight,
      highlightColor: AppColors.backgroundLight,
      child: Container(
        decoration: BoxDecoration(
          color: AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(12),
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(12),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              // Cover image
              Container(height: 160, color: AppColors.surfaceLight),

              Padding(
                padding: const EdgeInsets.fromLTRB(12, 10, 12, 12),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    // Description line 1
                    Container(
                        height: 12,
                        color: AppColors.surfaceLight),
                    const SizedBox(height: 6),
                    // Description line 2 (shorter)
                    Container(
                        height: 12,
                        width: 220,
                        color: AppColors.surfaceLight),
                    const SizedBox(height: 14),
                    const Divider(
                        height: 1,
                        thickness: 1,
                        color: AppColors.borderLight),
                    const SizedBox(height: 14),
                    // Info chips row
                    Row(
                      children: [
                        Container(
                            height: 10,
                            width: 60,
                            color: AppColors.surfaceLight),
                        const Spacer(),
                        Container(
                            height: 10,
                            width: 55,
                            color: AppColors.surfaceLight),
                        const Spacer(),
                        Container(
                            height: 10,
                            width: 50,
                            color: AppColors.surfaceLight),
                      ],
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
