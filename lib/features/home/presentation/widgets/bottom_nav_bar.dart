import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';

class AppBottomNavBar extends StatelessWidget {
  final int currentIndex;
  final ValueChanged<int> onTap;
  const AppBottomNavBar({super.key, required this.currentIndex, required this.onTap});

  static const _icons = [
    ('assets/icons/nav_home.svg',    'assets/icons/nav_home_active.svg'),
    ('assets/icons/nav_offers.svg',  'assets/icons/nav_offers_active.svg'),
    ('assets/icons/nav_cart.svg',    'assets/icons/nav_cart_active.svg'),
    ('assets/icons/nav_profile.svg', 'assets/icons/nav_profile_active.svg'),
  ];
  static const _keys = ['nav_home', 'nav_offers', 'nav_cart', 'nav_profile'];

  @override
  Widget build(BuildContext context) {
    final isDark  = Theme.of(context).brightness == Brightness.dark;
    final screenH = MediaQuery.of(context).size.height;
    final navH    = (screenH * 0.088).clamp(60.0, 76.0);
    return Container(
      margin: const EdgeInsets.fromLTRB(16, 0, 16, 16),
      height: navH,
      decoration: BoxDecoration(
        color: isDark ? AppColors.surfaceDark : AppColors.surfaceLight,
        borderRadius: BorderRadius.circular(22),
        boxShadow: [BoxShadow(
          color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
          blurRadius: 24, spreadRadius: 2, offset: const Offset(0, 4),
        )],
      ),
      child: Row(
        children: List.generate(4, (i) => Expanded(
          child: _NavItem(
            icon: currentIndex == i ? _icons[i].$2 : _icons[i].$1,
            label: context.tr(_keys[i]),
            isSelected: currentIndex == i,
            onTap: () => onTap(i),
            navHeight: navH,
          ),
        )),
      ),
    );
  }
}

class _NavItem extends StatelessWidget {
  final String icon;
  final String label;
  final bool isSelected;
  final VoidCallback onTap;
  final double navHeight;
  const _NavItem({
    required this.icon, required this.label, required this.isSelected,
    required this.onTap, required this.navHeight,
  });

  @override
  Widget build(BuildContext context) {
    final iconSz  = (navHeight * 0.34).clamp(18.0, 22.0);
    final vMargin = (navHeight * 0.10).clamp(5.0, 10.0);
    final vPad    = (navHeight * 0.07).clamp(3.0, 7.0);
    final color   = isSelected ? AppColors.primary : AppColors.iconLight;
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 220),
        curve: Curves.easeOut,
        margin: EdgeInsets.symmetric(horizontal: 6, vertical: vMargin),
        padding: EdgeInsets.symmetric(horizontal: 10, vertical: vPad),
        decoration: BoxDecoration(
          color: isSelected ? AppColors.primary.withValues(alpha: 0.12) : Colors.transparent,
          borderRadius: BorderRadius.circular(14),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            SvgPicture.asset(
              icon,
              width: iconSz, height: iconSz,
              colorFilter: ColorFilter.mode(color, BlendMode.srcIn),
            ),
            SizedBox(height: navHeight * 0.025),
            AnimatedDefaultTextStyle(
              duration: const Duration(milliseconds: 220),
              style: TextStyle(
                color: color, fontSize: 10,
                fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
              ),
              child: Text(label, maxLines: 1),
            ),
          ],
        ),
      ),
    );
  }
}
