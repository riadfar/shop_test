import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';
import 'shop_card.dart';
import 'shop_card_shimmer.dart';

class SliverShopList extends StatefulWidget {
  final bool fetchOnInit;
  const SliverShopList({super.key, this.fetchOnInit = true});

  @override
  State<SliverShopList> createState() => _SliverShopListState();
}

class _SliverShopListState extends State<SliverShopList> {
  @override
  void initState() {
    super.initState();
    if (widget.fetchOnInit) context.read<ShopBloc>().add(const FetchShops());
  }

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
              childCount: 5,
            ),
          );
        }

        if (state is ShopLoaded) {
          return SliverList.builder(
            itemCount: state.displayedShops.length,
            itemBuilder: (context, index) => Padding(
              padding: const EdgeInsets.fromLTRB(20, 0, 20, 12),
              child: ShopCard(shop: state.displayedShops[index]),
            ),
          );
        }

        if (state is ShopError) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.wifi_off_rounded,
                      size: 56, color: AppColors.iconLight),
                  const SizedBox(height: 12),
                  Text(state.message,
                      textAlign: TextAlign.center,
                      style: const TextStyle(color: AppColors.iconLight)),
                  const SizedBox(height: 16),
                  ElevatedButton(
                    onPressed: () =>
                        context.read<ShopBloc>().add(const FetchShops()),
                    child: Text(context.tr('retry')),
                  ),
                ],
              ),
            ),
          );
        }

        if (state is ShopEmpty) {
          return SliverFillRemaining(
            child: Center(
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  const Icon(Icons.search_off_rounded,
                      size: 56, color: AppColors.iconLight),
                  const SizedBox(height: 12),
                  Text(
                    '${context.tr('no_results_for')} "${state.query}"',
                    textAlign: TextAlign.center,
                    style: const TextStyle(color: AppColors.iconLight),
                  ),
                ],
              ),
            ),
          );
        }

        return const SliverToBoxAdapter(child: SizedBox.shrink());
      },
    );
  }
}
