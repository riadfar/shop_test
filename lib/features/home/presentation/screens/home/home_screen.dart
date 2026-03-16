import 'package:flutter/material.dart';
import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../data/dummy_data.dart';
import 'widgets/category_list.dart';
import 'widgets/food_section.dart';
import 'widgets/home_header.dart';
import 'widgets/promo_carousel.dart';
import 'widgets/search_bar_widget.dart';
import 'widgets/section_title.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: SingleChildScrollView(
          physics: const BouncingScrollPhysics(),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const HomeHeader(),
              const SearchBarWidget(),
              SectionTitle(title: context.tr('categories_section')),
              CategoryList(categories: DummyData.categories),
              SectionTitle(title: context.tr('special_offers_section'), onSeeAll: () {}),
              const SizedBox(height: 12),
              PromoCarousel(banners: DummyData.banners),
              FoodSection(
                title: context.tr('popular_section'),
                items: DummyData.popularItems,
              ),
              FoodSection(
                title: context.tr('trending_section'),
                items: DummyData.trendingItems,
              ),
              const SizedBox(height: 24),
            ],
          ),
        ),
      ),
    );
  }
}
