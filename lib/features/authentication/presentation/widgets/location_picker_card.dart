import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

/// A visually rich card that acts as a button to open the map picker.
class LocationPickerCard extends StatefulWidget {
  final VoidCallback? onTap;
  final String? selectedLocation;

  const LocationPickerCard({super.key, this.onTap, this.selectedLocation});

  @override
  State<LocationPickerCard> createState() => _LocationPickerCardState();
}

class _LocationPickerCardState extends State<LocationPickerCard>
    with SingleTickerProviderStateMixin {
  late final AnimationController _pinCtrl;
  late final Animation<double> _pinFloat;
  bool _isPressed = false;

  @override
  void initState() {
    super.initState();
    _pinCtrl = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 950),
    )..repeat(reverse: true);
    _pinFloat = Tween<double>(begin: 0, end: -7).animate(
      CurvedAnimation(parent: _pinCtrl, curve: Curves.easeInOut),
    );
  }

  @override
  void dispose() {
    _pinCtrl.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return GestureDetector(
      onTapDown: (_) => setState(() => _isPressed = true),
      onTapUp: (_) {
        setState(() => _isPressed = false);
        widget.onTap?.call();
      },
      onTapCancel: () => setState(() => _isPressed = false),
      child: AnimatedScale(
        scale: _isPressed ? 0.974 : 1.0,
        duration: const Duration(milliseconds: 100),
        curve: Curves.easeOut,
        child: Container(
          height: 148,
          clipBehavior: Clip.antiAlias,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(20),
            boxShadow: [
              BoxShadow(
                color: AppColors.primary.withOpacity(0.20),
                blurRadius: 28,
                spreadRadius: -6,
                offset: const Offset(0, 12),
              ),
              BoxShadow(
                color: isDark ? AppColors.shadowDark : AppColors.shadowLight,
                blurRadius: 8,
                offset: const Offset(0, 2),
              ),
            ],
          ),
          child: Stack(
            fit: StackFit.expand,
            children: [
              CustomPaint(painter: _MapPainter(isDark: isDark)),
              Positioned.fill(
                child: DecoratedBox(
                  decoration: BoxDecoration(
                    gradient: LinearGradient(
                      begin: Alignment.topCenter,
                      end: Alignment.bottomCenter,
                      stops: const [0.15, 1.0],
                      colors: [
                        Colors.transparent,
                        (isDark ? const Color(0xFF1C1C1E) : AppColors.surfaceLight)
                            .withOpacity(0.93),
                      ],
                    ),
                  ),
                ),
              ),
              Positioned.fill(
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  child: Row(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      _buildPinBubble(),
                      const SizedBox(width: 16),
                      Expanded(child: _buildTextContent(context, isDark)),
                      Icon(
                        Icons.chevron_right_rounded,
                        size: 22,
                        color: (isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight)
                            .withOpacity(0.30),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _buildPinBubble() {
    return AnimatedBuilder(
      animation: _pinFloat,
      builder: (_, child) =>
          Transform.translate(offset: Offset(0, _pinFloat.value), child: child),
      child: Container(
        width: 54,
        height: 54,
        decoration: BoxDecoration(
          gradient: const LinearGradient(
            begin: Alignment.topLeft,
            end: Alignment.bottomRight,
            colors: [AppColors.primary, AppColors.primaryVariant],
          ),
          shape: BoxShape.circle,
          boxShadow: [
            BoxShadow(
              color: AppColors.primary.withOpacity(0.48),
              blurRadius: 18,
              spreadRadius: -4,
              offset: const Offset(0, 7),
            ),
          ],
        ),
        child: const Icon(Icons.location_on_rounded, color: AppColors.onPrimary, size: 28),
      ),
    );
  }

  Widget _buildTextContent(BuildContext context, bool isDark) {
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return Column(
      mainAxisAlignment: MainAxisAlignment.center,
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          context.tr('set_home_location'),
          style: AppTextStyles.textTheme.titleSmall?.copyWith(
            color: onSurface, fontWeight: FontWeight.w700, letterSpacing: -0.2,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          widget.selectedLocation ?? context.tr('tap_to_set_location'),
          maxLines: 2,
          overflow: TextOverflow.ellipsis,
          style: AppTextStyles.textTheme.bodySmall?.copyWith(
            color: onSurface.withOpacity(0.52), height: 1.45,
          ),
        ),
        const SizedBox(height: 10),
        Container(
          padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 5),
          decoration: BoxDecoration(
            gradient: const LinearGradient(
              colors: [AppColors.primary, AppColors.primaryVariant],
            ),
            borderRadius: BorderRadius.circular(20),
          ),
          child: Row(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Icon(Icons.map_outlined, color: AppColors.onPrimary, size: 12),
              const SizedBox(width: 5),
              Text(
                context.tr('open_map'),
                style: const TextStyle(
                  color: AppColors.onPrimary, fontSize: 11,
                  fontWeight: FontWeight.w700, letterSpacing: 0.3,
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class _MapPainter extends CustomPainter {
  final bool isDark;
  const _MapPainter({required this.isDark});

  @override
  void paint(Canvas canvas, Size size) {
    final bgColor = isDark ? const Color(0xFF1E2A38) : const Color(0xFFEAF4EA);
    final gridColor = isDark ? const Color(0xFF253040) : const Color(0xFFD4E8D4);
    final roadColor = isDark ? const Color(0xFF2E3F52) : const Color(0xFFC4DCC4);
    final blockColor = isDark ? const Color(0xFF192430) : const Color(0xFFCDE4CD);
    final accentBlock = isDark ? const Color(0xFF1F3045) : const Color(0xFFB8D8B8);

    canvas.drawRect(Rect.fromLTWH(0, 0, size.width, size.height), Paint()..color = bgColor);

    final gridPaint = Paint()..color = gridColor..strokeWidth = 0.8;
    for (double x = 0; x < size.width; x += 28) {
      canvas.drawLine(Offset(x, 0), Offset(x, size.height), gridPaint);
    }
    for (double y = 0; y < size.height; y += 28) {
      canvas.drawLine(Offset(0, y), Offset(size.width, y), gridPaint);
    }

    final roadPaint = Paint()..color = roadColor;
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.34, size.width, 13), roadPaint);
    canvas.drawRect(Rect.fromLTWH(0, size.height * 0.68, size.width, 9), roadPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.30, 0, 13, size.height), roadPaint);
    canvas.drawRect(Rect.fromLTWH(size.width * 0.66, 0, 9, size.height), roadPaint);

    const r = Radius.circular(4);
    final blockPaint = Paint()..color = blockColor;
    final accentPaint = Paint()..color = accentBlock;
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.34, 5, size.width * 0.28, size.height * 0.28), r), blockPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(6, 5, size.width * 0.20, size.height * 0.27), r), accentPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(size.width * 0.70, size.height * 0.42, size.width * 0.27, size.height * 0.24), r), blockPaint);
    canvas.drawRRect(RRect.fromRectAndRadius(Rect.fromLTWH(6, size.height * 0.42, size.width * 0.20, size.height * 0.20), r), accentPaint);
  }

  @override
  bool shouldRepaint(_MapPainter old) => old.isDark != isDark;
}
