import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../injection_container.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../widgets/shop_filter_sheet.dart';
import '../widgets/shops_search_bar.dart';
import '../widgets/sliver_shop_list.dart';
import 'all_shops_args.dart';

class AllShopsScreen extends StatelessWidget {
  final AllShopsArgs args;
  const AllShopsScreen({super.key, this.args = const AllShopsArgs()});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => getIt<ShopBloc>()..add(const FetchShops()),
      child: _AllShopsView(args: args),
    );
  }
}

class _AllShopsView extends StatefulWidget {
  final AllShopsArgs args;
  const _AllShopsView({required this.args});

  @override
  State<_AllShopsView> createState() => _AllShopsViewState();
}

class _AllShopsViewState extends State<_AllShopsView> {
  @override
  void initState() {
    super.initState();
    if (widget.args.openFilter) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) showShopFilterSheet(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: SafeArea(
        child: CustomScrollView(
          physics: const BouncingScrollPhysics(),
          slivers: [
            const SliverToBoxAdapter(child: _ShopsHeader()),
            SliverToBoxAdapter(
              child: ShopsSearchBar(autoFocus: widget.args.autoFocusSearch),
            ),
            const SliverShopList(fetchOnInit: false),
            const SliverToBoxAdapter(child: SizedBox(height: 24)),
          ],
        ),
      ),
    );
  }
}

class _ShopsHeader extends StatelessWidget {
  const _ShopsHeader();

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface =
        isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 16, 20, 4),
      child: Row(
        children: [
          GestureDetector(
            onTap: () => Navigator.pop(context),
            child: Container(
              width: 40,
              height: 40,
              decoration: BoxDecoration(
                color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
                borderRadius: BorderRadius.circular(12),
                boxShadow: [
                  BoxShadow(
                    color: isDark
                        ? AppColors.shadowDark
                        : AppColors.shadowLight,
                    blurRadius: 8,
                    offset: const Offset(0, 2),
                  )
                ],
              ),
              child: Icon(
                isAr
                    ? Icons.arrow_forward_ios_rounded
                    : Icons.arrow_back_ios_rounded,
                color: onSurface,
                size: 18,
              ),
            ),
          ),
          const SizedBox(width: 14),
          Expanded(
            child: Text(
              context.tr('shops_section'),
              style: AppTextStyles.textTheme.titleLarge?.copyWith(
                color: onSurface,
                fontWeight: FontWeight.w800,
                letterSpacing: -0.5,
              ),
            ),
          ),
        ],
      ),
    );
  }
}