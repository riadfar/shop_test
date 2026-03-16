import 'package:flutter/material.dart';
import '../../../../../../core/localization/app_localizations.dart';
import '../../../../../../core/localization/dynamic_scaling.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';

class FontSizeCard extends StatelessWidget {
  const FontSizeCard({super.key});

  static const _scales = [0.85, 1.0, 1.2, 1.4];
  static const _labels = ['S', 'M', 'L', 'XL'];

  @override
  Widget build(BuildContext context) {
    final current   = DynamicTextScaling.of(context);
    final isDark    = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 13),
      child: Row(children: [
        Container(width: 38, height: 38,
          decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.10), borderRadius: BorderRadius.circular(11)),
          child: const Icon(Icons.text_fields_rounded, color: AppColors.primary, size: 18)),
        const SizedBox(width: 14),
        Expanded(child: Text(context.tr('font_size'),
          style: AppTextStyles.textTheme.bodyMedium?.copyWith(fontWeight: FontWeight.w600, color: onSurface))),
        Row(children: List.generate(4, (i) {
          final sel = (current - _scales[i]).abs() < 0.01;
          return GestureDetector(
            onTap: () => DynamicTextScaling.updateScale(context, _scales[i]),
            child: AnimatedContainer(
              duration: const Duration(milliseconds: 180),
              width: 32, height: 32, margin: const EdgeInsets.only(left: 6),
              decoration: BoxDecoration(
                color: sel ? AppColors.primary : AppColors.primary.withValues(alpha: 0.10),
                borderRadius: BorderRadius.circular(9),
              ),
              alignment: Alignment.center,
              child: Text(_labels[i], style: TextStyle(
                color: sel ? AppColors.onPrimary : AppColors.primary,
                fontWeight: FontWeight.w700, fontSize: 11,
              )),
            ),
          );
        })),
      ]),
    );
  }
}
