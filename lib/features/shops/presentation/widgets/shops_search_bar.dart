import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../bloc/shop_bloc.dart';
import '../bloc/shop_event.dart';
import 'shop_filter_sheet.dart';

/// Fully interactive search bar for [AllShopsScreen].
/// Supports auto-focus and filter sheet trigger.
class ShopsSearchBar extends StatefulWidget {
  final bool autoFocus;

  const ShopsSearchBar({super.key, this.autoFocus = false});

  @override
  State<ShopsSearchBar> createState() => _ShopsSearchBarState();
}

class _ShopsSearchBarState extends State<ShopsSearchBar> {
  final _controller = TextEditingController();
  late final FocusNode _focus;

  @override
  void initState() {
    super.initState();
    _focus = FocusNode();
    if (widget.autoFocus) {
      WidgetsBinding.instance.addPostFrameCallback((_) {
        if (mounted) _focus.requestFocus();
      });
    }
  }

  @override
  void dispose() {
    _controller.dispose();
    _focus.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: Container(
        height: 52,
        decoration: BoxDecoration(
          color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: [
            BoxShadow(
              color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 8,
              offset: const Offset(0, 2),
            )
          ],
        ),
        child: Row(
          children: [
            const SizedBox(width: 14),
            const Icon(Icons.search_rounded,
                color: AppColors.iconLight, size: 22),
            const SizedBox(width: 10),
            Expanded(
              child: TextField(
                controller: _controller,
                focusNode: _focus,
                onChanged: (q) =>
                    context.read<ShopBloc>().add(SearchShops(q)),
                style: TextStyle(
                  color: isDark
                      ? AppColors.onSurfaceDark
                      : AppColors.onSurfaceLight,
                  fontSize: 14,
                ),
                decoration: InputDecoration(
                  hintText: context.tr('search_hint'),
                  hintStyle: const TextStyle(
                      color: AppColors.iconLight, fontSize: 14),
                  border: InputBorder.none,
                  focusedBorder: InputBorder.none,
                  enabledBorder: InputBorder.none,
                  errorBorder: InputBorder.none,
                  focusedErrorBorder: InputBorder.none,
                  isDense: true,
                  contentPadding: EdgeInsets.zero,
                ),
              ),
            ),
            GestureDetector(
              onTap: () => showShopFilterSheet(context),
              child: Container(
                width: 36,
                height: 36,
                margin: const EdgeInsets.only(right: 8),
                decoration: BoxDecoration(
                  gradient: const LinearGradient(
                      colors: [AppColors.primary, AppColors.primaryVariant]),
                  borderRadius: BorderRadius.circular(10),
                ),
                child: const Icon(Icons.tune_rounded,
                    color: AppColors.onPrimary, size: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}