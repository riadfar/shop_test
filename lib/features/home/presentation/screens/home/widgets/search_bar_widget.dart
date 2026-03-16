import 'package:flutter/material.dart';

import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../shops/presentation/screens/all_shops_args.dart';
import '../../../../../shops/presentation/screens/all_shops_screen.dart';

/// Read-only dummy trigger on the Home screen.
/// Tapping the field navigates to [AllShopsScreen] with keyboard auto-focused.
/// Tapping the filter icon opens the filter sheet directly on arrival.
class SearchBarWidget extends StatelessWidget {
  const SearchBarWidget({super.key});

  void _navigate(BuildContext context, {bool openFilter = false}) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (_) => AllShopsScreen(
          args: AllShopsArgs(
            autoFocusSearch: !openFilter,
            openFilter: openFilter,
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Padding(
      padding: const EdgeInsets.fromLTRB(20, 14, 20, 4),
      child: GestureDetector(
        behavior: HitTestBehavior.opaque,
        onTap: () => _navigate(context),
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
                child: Text(
                  context.tr('search_hint'),
                  style: const TextStyle(
                      color: AppColors.iconLight, fontSize: 14),
                ),
              ),
              GestureDetector(
                onTap: () => _navigate(context, openFilter: true),
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
      ),
    );
  }
}