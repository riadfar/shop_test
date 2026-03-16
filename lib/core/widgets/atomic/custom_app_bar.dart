import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

/// Minimalist, zero-elevation app bar that plays well with both
/// light and dark themes. Provides an optional `transparent` mode
/// (useful for screens that render behind the status bar).
class CustomAppBar extends StatelessWidget implements PreferredSizeWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;

  /// Defaults to 0 — override only when you need a visible shadow.
  final double? elevation;
  final PreferredSizeWidget? bottom;
  final bool automaticallyImplyLeading;
  final double height;

  /// When true the app bar is fully transparent. Useful for hero/full-bleed
  /// screens that still need a status-bar safe area.
  final bool transparent;

  const CustomAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.bottom,
    this.automaticallyImplyLeading = true,
    this.height = kToolbarHeight,
    this.transparent = false,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    final effectiveBg = transparent
        ? Colors.transparent
        : (backgroundColor ??
            (isDark ? AppColors.backgroundDark : AppColors.backgroundLight));

    final effectiveFg = foregroundColor ??
        (isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight);

    final canPop = Navigator.of(context).canPop();

    return AppBar(
      // Title
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: effectiveFg,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            )
          : null,

      // Leading — prefer caller-supplied, fall back to our custom back button
      leading: leading ??
          (automaticallyImplyLeading && canPop
              ? _BackButton(color: effectiveFg)
              : null),

      // Disable Flutter's own leading logic — we handle it above
      automaticallyImplyLeading: false,

      actions: actions,
      centerTitle: centerTitle,
      backgroundColor: effectiveBg,
      foregroundColor: effectiveFg,
      elevation: elevation,

      // Prevent Material 3 from re-adding a tinted shadow on scroll
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      shadowColor: Colors.transparent,

      bottom: bottom,
      iconTheme: IconThemeData(color: effectiveFg),
      titleTextStyle: TextStyle(
        color: effectiveFg,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
    );
  }

  @override
  Size get preferredSize =>
      Size.fromHeight(height + (bottom?.preferredSize.height ?? 0));
}

// ── Custom back button ─────────────────────────────────────────────────────

class _BackButton extends StatefulWidget {
  final Color color;

  const _BackButton({required this.color});

  @override
  State<_BackButton> createState() => _BackButtonState();
}

class _BackButtonState extends State<_BackButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) {
        setState(() => _pressed = false);
        Navigator.of(context).maybePop();
      },
      onTapCancel: () => setState(() => _pressed = false),
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        margin: const EdgeInsets.all(8),
        decoration: BoxDecoration(
          color: widget.color.withOpacity(_pressed ? 0.14 : 0.07),
          borderRadius: BorderRadius.circular(12),
        ),
        child: Icon(
          Icons.arrow_back_ios_new_rounded,
          color: widget.color,
          size: 18,
        ),
      ),
    );
  }
}

// ── Sliver variant ─────────────────────────────────────────────────────────

class CustomSliverAppBar extends StatelessWidget {
  final String? title;
  final List<Widget>? actions;
  final Widget? leading;
  final bool centerTitle;
  final Color? backgroundColor;
  final Color? foregroundColor;
  final double? elevation;
  final bool floating;
  final bool pinned;
  final bool snap;
  final double expandedHeight;
  final Widget? flexibleSpace;
  final bool automaticallyImplyLeading;

  const CustomSliverAppBar({
    super.key,
    this.title,
    this.actions,
    this.leading,
    this.centerTitle = true,
    this.backgroundColor,
    this.foregroundColor,
    this.elevation = 0,
    this.floating = false,
    this.pinned = true,
    this.snap = false,
    this.expandedHeight = 0,
    this.flexibleSpace,
    this.automaticallyImplyLeading = true,
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final effectiveBg = backgroundColor ??
        (isDark ? AppColors.backgroundDark : AppColors.backgroundLight);
    final effectiveFg = foregroundColor ??
        (isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight);

    return SliverAppBar(
      title: title != null
          ? Text(
              title!,
              style: TextStyle(
                color: effectiveFg,
                fontSize: 18,
                fontWeight: FontWeight.w600,
                letterSpacing: -0.3,
              ),
            )
          : null,
      actions: actions,
      leading: leading,
      centerTitle: centerTitle,
      backgroundColor: effectiveBg,
      foregroundColor: effectiveFg,
      elevation: elevation,
      scrolledUnderElevation: 0,
      surfaceTintColor: Colors.transparent,
      floating: floating,
      pinned: pinned,
      snap: snap,
      expandedHeight: expandedHeight,
      flexibleSpace: flexibleSpace,
      automaticallyImplyLeading: automaticallyImplyLeading,
      iconTheme: IconThemeData(color: effectiveFg),
      titleTextStyle: TextStyle(
        color: effectiveFg,
        fontSize: 18,
        fontWeight: FontWeight.w600,
        letterSpacing: -0.3,
      ),
    );
  }
}
