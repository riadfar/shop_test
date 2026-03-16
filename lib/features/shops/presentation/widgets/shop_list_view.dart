import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/theme/app_colors.dart';
import '../../domain/entities/shop.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';
import 'shop_card.dart';
import 'shop_card_shimmer.dart';

/// Root widget for the shop list. Dispatches [FetchShops] on mount and
/// delegates each BLoC state to a dedicated private widget.
class ShopListView extends StatefulWidget {
  const ShopListView({super.key});

  @override
  State<ShopListView> createState() => _ShopListViewState();
}

class _ShopListViewState extends State<ShopListView> {
  @override
  void initState() {
    super.initState();
    context.read<ShopBloc>().add(const FetchShops());
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<ShopBloc, ShopState>(
      builder: (context, state) {
        if (state is ShopLoading || state is ShopInitial) {
          return const _ShimmerList();
        }
        if (state is ShopError) {
          return _ErrorView(
            message: state.message,
            onRetry: () => context.read<ShopBloc>().add(const FetchShops()),
          );
        }
        if (state is ShopEmpty) return _EmptyView(query: state.query);
        if (state is ShopLoaded) return _LoadedList(shops: state.displayedShops);
        return const SizedBox.shrink();
      },
    );
  }
}

class _ShimmerList extends StatelessWidget {
  const _ShimmerList();

  @override
  Widget build(BuildContext context) => ListView.separated(
        itemCount: 5,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, __) => const ShopCardShimmer(),
      );
}

class _LoadedList extends StatelessWidget {
  final List<Shop> shops;

  const _LoadedList({required this.shops});

  @override
  Widget build(BuildContext context) => ListView.separated(
        itemCount: shops.length,
        padding: const EdgeInsets.all(16),
        separatorBuilder: (_, __) => const SizedBox(height: 12),
        itemBuilder: (_, i) => ShopCard(shop: shops[i]),
      );
}

class _ErrorView extends StatelessWidget {
  final String message;
  final VoidCallback onRetry;

  const _ErrorView({required this.message, required this.onRetry});

  @override
  Widget build(BuildContext context) => Center(
        child: Padding(
          padding: const EdgeInsets.all(32),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              const Icon(Icons.wifi_off_rounded,
                  size: 72, color: AppColors.iconLight),
              const SizedBox(height: 16),
              Text(message,
                  style: Theme.of(context)
                      .textTheme
                      .bodyMedium
                      ?.copyWith(color: AppColors.iconLight),
                  textAlign: TextAlign.center),
              const SizedBox(height: 24),
              ElevatedButton.icon(
                onPressed: onRetry,
                icon: const Icon(Icons.refresh_rounded),
                label: const Text('Try Again'),
              ),
            ],
          ),
        ),
      );
}

class _EmptyView extends StatelessWidget {
  final String query;

  const _EmptyView({required this.query});

  @override
  Widget build(BuildContext context) => Center(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Icon(Icons.search_off_rounded,
                size: 72, color: AppColors.iconLight),
            const SizedBox(height: 16),
            Text(
              query.isEmpty ? 'No shops available.' : 'No results for "$query".',
              style: Theme.of(context)
                  .textTheme
                  .bodyMedium
                  ?.copyWith(color: AppColors.iconLight),
              textAlign: TextAlign.center,
            ),
          ],
        ),
      );
}
