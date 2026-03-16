import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';

class ProfileHeader extends StatelessWidget {
  const ProfileHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return Stack(
      clipBehavior: Clip.none,
      alignment: Alignment.bottomCenter,
      children: [
        ClipPath(
          clipper: _CurveClipper(),
          child: Container(
            height: 210,
            decoration: const BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.topLeft,
                end: Alignment.bottomRight,
                colors: [AppColors.primary, AppColors.primaryVariant],
              ),
            ),
            child: const Stack(children: [
              _DecoCircle(right: -30, top: -30, radius: 110, opacity: 0.10),
              _DecoCircle(left: -20, bottom: 40, radius: 80, opacity: 0.08),
              _DecoCircle(right: 60, top: 50, radius: 50, opacity: 0.06),
            ]),
          ),
        ),
        Positioned(
          bottom: -44,
          child: Container(
            width: 90, height: 90,
            decoration: BoxDecoration(
              shape: BoxShape.circle,
              color: AppColors.surfaceLight,
              border: Border.all(color: AppColors.onPrimary, width: 3.5),
              boxShadow: [BoxShadow(color: AppColors.primary.withValues(alpha: 0.30), blurRadius: 22, offset: const Offset(0, 8))],
            ),
            child: const Icon(Icons.person_rounded, size: 50, color: AppColors.primary),
          ),
        ),
      ],
    );
  }
}

class _CurveClipper extends CustomClipper<Path> {
  @override
  Path getClip(Size size) => Path()
    ..lineTo(0, size.height - 44)
    ..quadraticBezierTo(size.width / 2, size.height + 18, size.width, size.height - 44)
    ..lineTo(size.width, 0)
    ..close();
  @override bool shouldReclip(_) => false;
}

class _DecoCircle extends StatelessWidget {
  final double radius, opacity;
  final double? left, right, top, bottom;
  const _DecoCircle({required this.radius, required this.opacity, this.left, this.right, this.top, this.bottom});
  @override
  Widget build(BuildContext context) => Positioned(
    left: left, right: right, top: top, bottom: bottom,
    child: Container(
      width: radius * 2, height: radius * 2,
      decoration: BoxDecoration(shape: BoxShape.circle, color: AppColors.onPrimary.withValues(alpha: opacity)),
    ),
  );
}
