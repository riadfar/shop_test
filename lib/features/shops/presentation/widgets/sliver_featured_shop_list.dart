import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/shop_bloc.dart';
import '../bloc/shop_state.dart';
import 'shop_card.dart';
import 'shop_card_shimmer.dart';

class SliverFeaturedShopList extends StatelessWidget {
  const SliverFeaturedShopList({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopInitial || state is ShopLoading) {
          return SliverList(
            delegate: SliverChildBuilderDelegate(
              (_, __) => const Padding(
                padding: EdgeInsets.fromLTRB(20, 0, 20, 12),
                child: ShopCardShimmer(),
              ),
              childCount: 3,
            ),
          );
        }

        if (state is ShopLoaded) {
          return SliverList.builder(
            itemCount: state.featuredShops.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: ShopCard(shop: state.featuredShops[index]),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
