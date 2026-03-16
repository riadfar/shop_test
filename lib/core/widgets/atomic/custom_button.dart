import 'package:flutter/material.dart';

import '../../theme/app_colors.dart';

enum ButtonType { primary, secondary, outline, text, danger }

/// Premium CTA button with a physical press-scale animation,
/// gradient fill (primary type), and animated shadow lift.
class CustomButton extends StatefulWidget {
  final String text;
  final VoidCallback? onPressed;
  final ButtonType type;
  final bool isLoading;
  final bool isEnabled;
  final IconData? icon;
  final double? width;
  final double? height;

  const CustomButton({
    super.key,
    required this.text,
    this.onPressed,
    this.type = ButtonType.primary,
    this.isLoading = false,
    this.isEnabled = true,
    this.icon,
    this.width,
    this.height,
  });

  @override
  State<CustomButton> createState() => _CustomButtonState();
}

class _CustomButtonState extends State<CustomButton>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pressCtrl;
  late final Animation<double> _scaleAnim;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pressCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 80),
      reverseDuration: const Duration(milliseconds: 180),
    );
    _scaleAnim = Tween<double>(begin: 1.0, end: 0.962).animate(
      CurvedAnimation(parent: _pressCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pressCtrl.dispose();
    super.dispose();
  }

  bool get _canInteract =>
      widget.isEnabled && !widget.isLoading && widget.onPressed != null;

  void _down(TapDownDetails _) {
    if (!_canInteract) return;
    setState(() => _isPressed = true);
    _pressCtrl.forward();
  }

  void _up(TapUpDetails _) {
    if (!_isPressed) return;
    setState(() => _isPressed = false);
    _pressCtrl.reverse();
  }

  void _cancel() {
    if (!_isPressed) return;
    setState(() => _isPressed = false);
    _pressCtrl.reverse();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTapDown: _down,
      onTapUp: _up,
      onTapCancel: _cancel,
      onTap: _canInteract ? widget.onPressed : null,
      child: ScaleTransition(
        scale: _scaleAnim,
        child: AnimatedContainer(
          duration: const Duration(milliseconds: 200),
          curve: Curves.easeOut,
          width: widget.width ?? double.infinity,
          height: widget.height ?? 54,
          decoration: _decoration(),
          child: Center(child: _content()),
        ),
      ),
    );
  }

  // ── Decoration per type ────────────────────────────────────────────────────

  BoxDecoration _decoration() {
    switch (widget.type) {
      case ButtonType.primary:
        return BoxDecoration(
          gradient: _canInteract
              ? const LinearGradient(
                  begin: Alignment.centerLeft,
                  end: Alignment.centerRight,
                  colors: [AppColors.primary, AppColors.primaryVariant],
                )
              : null,
          color: _canInteract ? null : AppColors.disabledLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _canInteract && !_isPressed
              ? [
                  BoxShadow(
                    color: AppColors.primary.withOpacity(0.40),
                    blurRadius: 20,
                    spreadRadius: -3,
                    offset: const Offset(0, 9),
                  ),
                ]
              : [],
        );

      case ButtonType.secondary:
        return BoxDecoration(
          color: _canInteract ? AppColors.secondary : AppColors.disabledLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _canInteract && !_isPressed
              ? [
                  BoxShadow(
                    color: AppColors.secondary.withOpacity(0.32),
                    blurRadius: 16,
                    spreadRadius: -3,
                    offset: const Offset(0, 7),
                  ),
                ]
              : [],
        );

      case ButtonType.outline:
        return BoxDecoration(
          color: Colors.transparent,
          border: Border.all(
            color: _canInteract ? AppColors.primary : AppColors.disabledLight,
            width: 1.8,
          ),
          borderRadius: BorderRadius.circular(16),
        );

      case ButtonType.text:
        return const BoxDecoration(color: Colors.transparent);

      case ButtonType.danger:
        return BoxDecoration(
          color: _canInteract ? AppColors.error : AppColors.disabledLight,
          borderRadius: BorderRadius.circular(16),
          boxShadow: _canInteract && !_isPressed
              ? [
                  BoxShadow(
                    color: AppColors.error.withOpacity(0.28),
                    blurRadius: 14,
                    spreadRadius: -3,
                    offset: const Offset(0, 6),
                  ),
                ]
              : [],
        );
    }
  }

  // ── Content ────────────────────────────────────────────────────────────────

  Widget _content() {
    if (widget.isLoading) {
      return SizedBox(
        width: 22,
        height: 22,
        child: CircularProgressIndicator(
          strokeWidth: 2.5,
          valueColor: AlwaysStoppedAnimation<Color>(_contentColor()),
        ),
      );
    }

    final style = TextStyle(
      color: _contentColor(),
      fontSize: 16,
      fontWeight: FontWeight.w700,
      letterSpacing: 0.4,
    );

    if (widget.icon != null) {
      return Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(widget.icon, size: 20, color: _contentColor()),
          const SizedBox(width: 8),
          Text(widget.text, style: style),
        ],
      );
    }

    return Text(widget.text, style: style);
  }

  Color _contentColor() {
    if (!_canInteract) {
      return AppColors.onSurfaceLight.withOpacity(0.38);
    }
    switch (widget.type) {
      case ButtonType.primary:
        return AppColors.onPrimary;
      case ButtonType.secondary:
        return AppColors.onSecondary;
      case ButtonType.outline:
        return AppColors.primary;
      case ButtonType.text:
        return AppColors.primary;
      case ButtonType.danger:
        return AppColors.onError;
    }
  }
}
