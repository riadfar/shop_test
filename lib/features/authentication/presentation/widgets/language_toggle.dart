import 'package:flutter/material.dart';

import '../../../../app/app.dart';
import '../../../../core/theme/app_colors.dart';

class LanguageToggleButton extends StatefulWidget {
  const LanguageToggleButton({super.key});

  @override
  State<LanguageToggleButton> createState() => _LanguageToggleButtonState();
}

class _LanguageToggleButtonState extends State<LanguageToggleButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 200));
  }

  @override
  void dispose() { _pressCtrl.dispose(); super.dispose(); }

  void _toggle() {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    MyApp.setLocale(context, isAr ? const Locale('en', 'US') : const Locale('ar'));
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return GestureDetector(
      onTapDown: (_) => _pressCtrl.forward(),
      onTapUp: (_) { _pressCtrl.reverse(); _toggle(); },
      onTapCancel: () => _pressCtrl.reverse(),
      child: AnimatedBuilder(
        animation: _pressCtrl,
        builder: (_, child) =>
            Transform.scale(scale: 1.0 - (_pressCtrl.value * 0.07), child: child),
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 250),
          curve: Curves.easeInOut,
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
          decoration: BoxDecoration(
            gradient: isAr
                ? const LinearGradient(colors: [AppColors.primary, AppColors.primaryVariant])
                : null,
            color: isAr ? null : (isDark ? AppColors.surfaceDark : AppColors.surfaceLight),
            borderRadius: BorderRadius.circular(20),
            border: Border.all(
              color: isAr ? Colors.transparent : AppColors.primary.withOpacity(0.35),
              width: 1.5,
            ),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(isAr ? 0.32 : 0.08),
                blurRadius: 12, spreadRadius: -3, offset: const Offset(0, 4),
              ),
            ],
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              Text(isAr ? '🇸🇦' : '🇺🇸', style: const TextStyle(fontSize: 13)),
              const SizedBox(width: 5),
              AnimatedDefaultTextStyle(
                duration: const Duration(milliseconds: 200),
                style: TextStyle(
                  color: isAr ? AppColors.onPrimary : AppColors.primary,
                  fontSize: 12, fontWeight: FontWeight.w700, letterSpacing: 0.5,
                ),
                child: Text(isAr ? 'AR' : 'EN'),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
