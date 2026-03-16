import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import '../bloc/shop_state.dart';
import 'shop_filter_actions.dart';
import 'shop_sort_option.dart';

void showShopFilterSheet(BuildContext context) {
  final bloc = context.read<ShopBloc>();
  showModalBottomSheet(
    context: context,
    isScrollControlled: true,
    backgroundColor: Colors.transparent,
    builder: (_) =>
        BlocProvider.value(value: bloc, child: const _FilterContent()),
  );
}

class _FilterContent extends StatefulWidget {
  const _FilterContent();

  @override
  State<_FilterContent> createState() => _FilterContentState();
}

class _FilterContentState extends State<_FilterContent> {
  late SortType _sort;
  late bool _openOnly;

  @override
  void initState() {
    super.initState();
    final s = context.read<ShopBloc>().state;
    _sort = s is ShopLoaded ? s.activeSort : SortType.none;
    _openOnly = s is ShopLoaded ? s.isOpenOnly : false;
  }

  void _apply() {
    final bloc = context.read<ShopBloc>();
    final current = bloc.state;
    if (current is ShopLoaded && _openOnly != current.isOpenOnly) {
      bloc.add(const ToggleOpenOnly());
    }
    bloc.add(SortShops(_sort,
        locale: Localizations.localeOf(context).languageCode));
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(24)),
      ),
      padding: const EdgeInsets.fromLTRB(20, 12, 20, 32),
      child: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Center(
              child: Container(
                width: 40,
                height: 4,
                decoration: BoxDecoration(
                  color: AppColors.borderLight,
                  borderRadius: BorderRadius.circular(2),
                ),
              ),
            ),
            const SizedBox(height: 20),
            Text(context.tr('sort_by'),
                style: const TextStyle(
                    fontSize: 15, fontWeight: FontWeight.w600)),
            const SizedBox(height: 8),
            ...SortType.values.map((t) => ShopSortOption(
                  label: sortTypeLabel(context, t),
                  value: t,
                  groupValue: _sort,
                  onChanged: (v) => setState(() => _sort = v),
                )),
            const Divider(height: 28),
            ShopFilterActions(
              openOnly: _openOnly,
              onOpenOnlyChanged: (v) => setState(() => _openOnly = v),
              onApply: _apply,
              onReset: () {
                context.read<ShopBloc>().add(const ClearFilters());
                Navigator.pop(context);
              },
            ),
          ],
        ),
      ),
    );
  }
}