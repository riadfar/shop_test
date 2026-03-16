import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atomic/custom_button.dart';
import '../../../../core/widgets/atomic/custom_text_field.dart';
import 'or_divider.dart';
import 'social_button.dart';

class FormSection extends StatelessWidget {
  final GlobalKey<FormState> formKey;
  final TextEditingController emailCtrl, passwordCtrl;
  final bool isLoading, isDark;
  final Future<void> Function() onLogin;
  final VoidCallback? onForgotPassword, onSignUp;

  const FormSection({
    super.key, required this.formKey, required this.emailCtrl,
    required this.passwordCtrl, required this.isLoading, required this.isDark,
    required this.onLogin, this.onForgotPassword, this.onSignUp,
  });

  @override
  Widget build(BuildContext context) {
    final textTheme = Theme.of(context).textTheme;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;

    return Padding(
      padding: const EdgeInsets.fromLTRB(24, 28, 24, 40),
      child: Form(
        key: formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(context.tr('welcome_back'), style: textTheme.headlineMedium?.copyWith(color: onSurface, fontWeight: FontWeight.w800, letterSpacing: -0.5, height: 1.15)),
            const SizedBox(height: 6),
            Text(context.tr('sign_in_to_continue'), style: textTheme.bodyMedium?.copyWith(color: onSurface.withOpacity(0.52), height: 1.55)),
            const SizedBox(height: 32),
            CustomTextField(controller: emailCtrl, hintText:context.tr('email'), type: TextFieldType.email, isRequired: true, textInputAction: TextInputAction.next, prefixIcon: const Icon(Icons.email_outlined)),
            const SizedBox(height: 16),
            CustomTextField(controller: passwordCtrl, hintText: context.tr('password'), type: TextFieldType.password, isRequired: true, textInputAction: TextInputAction.done, prefixIcon: const Icon(Icons.lock_outline_rounded)),
            const SizedBox(height: 10),
            Align(
              alignment: Alignment.centerRight,
              child: TextButton(
                onPressed: onForgotPassword,
                style: TextButton.styleFrom(foregroundColor: AppColors.primary, padding: const EdgeInsets.symmetric(horizontal: 4, vertical: 4), minimumSize: Size.zero, tapTargetSize: MaterialTapTargetSize.shrinkWrap),
                child: Text(context.tr('forgot_password'), style: textTheme.bodySmall?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w600, letterSpacing: 0.1)),
              ),
            ),
            const SizedBox(height: 26),
            CustomButton(text: context.tr('login'), onPressed: onLogin, type: ButtonType.primary, isLoading: isLoading, height: 56),
            const SizedBox(height: 36),
            OrDivider(onSurface: onSurface),
            const SizedBox(height: 28),
            Row(
              children: [
                Expanded(child: SocialButton(
                  imageAsset: 'assets/icons/google.png',
                  label: 'Google',
                  isDark: isDark,
                ),),
                const SizedBox(width: 14),
                Expanded(child: SocialButton(icon: Icons.apple_rounded, label: 'Apple', isDark: isDark)),
              ],
            ),
            const SizedBox(height: 36),
            Center(
              child: RichText(
                text: TextSpan(
                  text: "${context.tr('dont_have_account')}    ",
                  style: textTheme.bodyMedium?.copyWith(color: onSurface.withOpacity(0.52)),
                  children: [TextSpan(text:context.tr('sign_up_button'), style: textTheme.bodyMedium?.copyWith(color: AppColors.primary, fontWeight: FontWeight.w700), recognizer: TapGestureRecognizer()..onTap = onSignUp)],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}