import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../../core/localization/app_localizations.dart';
import '../../../../../core/theme/app_colors.dart';
import '../../../../../injection_container.dart';
import '../../../../shops/presentation/bloc/shop_bloc.dart';
import '../../../../shops/presentation/bloc/shop_event.dart';
import '../../../../shops/presentation/screens/all_shops_screen.dart';
import '../../../../shops/presentation/widgets/sliver_featured_shop_list.dart';
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
    return BlocProvider<ShopBloc>(
      create: (_) => getIt<ShopBloc>()..add(const FetchShops()),
      child: Builder(
        builder: (ctx) => Scaffold(
          backgroundColor:
              isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
          body: SafeArea(
            child: CustomScrollView(
              physics: const BouncingScrollPhysics(),
              slivers: [
                const SliverToBoxAdapter(child: HomeHeader()),
                const SliverToBoxAdapter(child: SearchBarWidget()),
                SliverToBoxAdapter(
                  child: SectionTitle(
                      title: ctx.tr('categories_section')),
                ),
                const SliverToBoxAdapter(
                  child: CategoryList(categories: DummyData.categories),
                ),
                SliverToBoxAdapter(
                  child: SectionTitle(
                      title: ctx.tr('special_offers_section'),
                      onSeeAll: () {}),
                ),
                const SliverToBoxAdapter(child: SizedBox(height: 12)),
                const SliverToBoxAdapter(
                    child: PromoCarousel(banners: DummyData.banners)),
                SliverToBoxAdapter(
                  child: FoodSection(
                      title: ctx.tr('popular_section'),
                      items: DummyData.popularItems),
                ),
                SliverToBoxAdapter(
                  child: FoodSection(
                      title: ctx.tr('trending_section'),
                      items: DummyData.trendingItems),
                ),
                SliverToBoxAdapter(
                  child: SectionTitle(
                    title: ctx.tr('featured_shops'),
                    onSeeAll: () => Navigator.push(
                      ctx,
                      MaterialPageRoute(
                          builder: (_) => const AllShopsScreen()),
                    ),
                  ),
                ),
                const SliverFeaturedShopList(),
                const SliverToBoxAdapter(child: SizedBox(height: 24)),
              ],
            ),
          ),
        ),
      ),
    );
  }
}