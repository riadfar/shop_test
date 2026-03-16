import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';

class SignUpLoginCta extends StatelessWidget {
  final VoidCallback? onLogin;
  const SignUpLoginCta({super.key, this.onLogin});

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bodyColor = (isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight)
        .withOpacity(0.60);
    return Center(
      child: Wrap(
        alignment: WrapAlignment.center,
        crossAxisAlignment: WrapCrossAlignment.center,
        children: [
          Text(
            context.tr('already_have_account'),
            style: AppTextStyles.textTheme.bodyMedium?.copyWith(color: bodyColor),
          ),
          GestureDetector(
            onTap: onLogin,
            child: Text(
              context.tr('login'),
              style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                color: AppColors.primary,
                fontWeight: FontWeight.w700,
                decoration: TextDecoration.underline,
                decorationColor: AppColors.primary,
                decorationThickness: 1.6,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
