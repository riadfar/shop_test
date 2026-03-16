import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class CustomLoadingIndicator extends StatelessWidget {
  final double size;
  final Color color;
  final double strokeWidth;
  final String? message;
  final bool showBackground;
  final Color? backgroundColor;

  const CustomLoadingIndicator({
    super.key,
    this.size = 40,
    this.color = AppColors.primary,
    this.strokeWidth = 3,
    this.message,
    this.showBackground = false,
    this.backgroundColor,
  });

  @override
  Widget build(BuildContext context) {
    if (showBackground) {
      return Container(
        color: backgroundColor ?? Colors.black.withOpacity(0.5),
        child: Center(
          child: _buildContent(),
        ),
      );
    }

    return _buildContent();
  }

  Widget _buildContent() {
    if (message != null) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          _buildIndicator(),
          const SizedBox(height: 16),
          Text(
            message!,
            style: const TextStyle(
              fontSize: 14,
              color: AppColors.onSurfaceLight,
            ),
          ),
        ],
      );
    }

    return _buildIndicator();
  }

  Widget _buildIndicator() {
    return SizedBox(
      width: size,
      height: size,
      child: CircularProgressIndicator(
        valueColor: AlwaysStoppedAnimation<Color>(color),
        strokeWidth: strokeWidth,
      ),
    );
  }
}

class CustomLoadingOverlay extends StatelessWidget {
  final bool isLoading;
  final Widget child;
  final String? message;
  final Color? overlayColor;

  const CustomLoadingOverlay({
    super.key,
    required this.isLoading,
    required this.child,
    this.message,
    this.overlayColor,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        child,
        if (isLoading)
          Positioned.fill(
            child: CustomLoadingIndicator(
              showBackground: true,
              backgroundColor: overlayColor,
              message: message,
            ),
          ),
      ],
    );
  }
}