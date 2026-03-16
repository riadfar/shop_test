import 'package:flutter/material.dart';
import '../../../../core/theme/app_colors.dart';

class SocialButton extends StatefulWidget {
  final IconData? icon;
  final String? imageAsset;
  final String label;
  final bool isDark;

  const SocialButton({
    super.key,
    required this.label,
    required this.isDark,
    this.icon,
    this.imageAsset,
  }) : assert(icon != null || imageAsset != null, 'You must provide either an icon or an imageAsset!');

  @override
  State<SocialButton> createState() => _SocialButtonState();
}

class _SocialButtonState extends State<SocialButton> {
  bool _pressed = false;

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onSurface = widget.isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    final surface = widget.isDark ? AppColors.surfaceDark : AppColors.surfaceLight;
    final border = widget.isDark ? AppColors.borderDark : AppColors.borderLight;

    return GestureDetector(
      onTapDown: (_) => setState(() => _pressed = true),
      onTapUp: (_) => setState(() => _pressed = false),
      onTapCancel: () => setState(() => _pressed = false),
      onTap: () {
        // TODO: wire up social auth
      },
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 120),
        height: 50,
        decoration: BoxDecoration(
          color: surface,
          borderRadius: BorderRadius.circular(14),
          border: Border.all(color: border, width: 1.2),
          boxShadow: _pressed ? [] : [
            BoxShadow(
              color: widget.isDark ? AppColors.shadowDark : AppColors.shadowLight,
              blurRadius: 6,
              offset: const Offset(0, 2),
            ),
          ],
        ),
        child: Transform.scale(
          scale: _pressed ? 0.96 : 1.0,
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (widget.imageAsset != null)
                Image.asset(
                  widget.imageAsset!,
                  height: 22,
                  width: 22,
                )
              else if (widget.icon != null)
                Icon(widget.icon, size: 22, color: onSurface),

              const SizedBox(width: 8),

              Text(
                widget.label,
                style: textTheme.labelLarge?.copyWith(
                  color: onSurface, fontWeight: FontWeight.w600, letterSpacing: 0.2,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}