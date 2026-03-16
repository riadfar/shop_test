import 'package:flutter/material.dart';
import '../../theme/app_colors.dart';

class ErrorDisplay extends StatelessWidget {
  final String message;
  final VoidCallback? onRetry;
  final String? retryButtonText;
  final IconData? icon;
  final Color? iconColor;
  final TextStyle? messageStyle;
  final bool showRetryButton;

  const ErrorDisplay({
    super.key,
    required this.message,
    this.onRetry,
    this.retryButtonText = 'Try Again',
    this.icon = Icons.error_outline,
    this.iconColor,
    this.messageStyle,
    this.showRetryButton = true,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: iconColor ?? AppColors.error,
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: messageStyle ?? const TextStyle(
                fontSize: 16,
                color: AppColors.onSurfaceLight,
              ),
              textAlign: TextAlign.center,
            ),
            if (showRetryButton && onRetry != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onRetry,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                ),
                child: Text(retryButtonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}

class EmptyDisplay extends StatelessWidget {
  final String message;
  final IconData? icon;
  final Color? iconColor;
  final TextStyle? messageStyle;
  final String? buttonText;
  final VoidCallback? onButtonPressed;

  const EmptyDisplay({
    super.key,
    required this.message,
    this.icon = Icons.inbox_outlined,
    this.iconColor,
    this.messageStyle,
    this.buttonText,
    this.onButtonPressed,
  });

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: const EdgeInsets.all(24),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Icon(
              icon,
              size: 64,
              color: iconColor ?? AppColors.iconLight.withOpacity(0.5),
            ),
            const SizedBox(height: 16),
            Text(
              message,
              style: messageStyle ?? TextStyle(
                fontSize: 16,
                color: AppColors.onSurfaceLight.withOpacity(0.6),
              ),
              textAlign: TextAlign.center,
            ),
            if (buttonText != null && onButtonPressed != null) ...[
              const SizedBox(height: 24),
              ElevatedButton(
                onPressed: onButtonPressed,
                style: ElevatedButton.styleFrom(
                  backgroundColor: AppColors.primary,
                  foregroundColor: AppColors.onPrimary,
                ),
                child: Text(buttonText!),
              ),
            ],
          ],
        ),
      ),
    );
  }
}