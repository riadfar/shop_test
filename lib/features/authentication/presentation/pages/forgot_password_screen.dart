import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/atomic/custom_app_bar.dart';
import '../../../../core/widgets/atomic/custom_button.dart';
import '../../../../core/widgets/atomic/custom_text_field.dart';

class ForgotPasswordScreen extends StatefulWidget {
  final void Function(String email)? onCodeSent;
  const ForgotPasswordScreen({super.key, this.onCodeSent});
  @override State<ForgotPasswordScreen> createState() => _ForgotPasswordScreenState();
}

class _ForgotPasswordScreenState extends State<ForgotPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() { _emailCtrl.dispose(); super.dispose(); }

  Future<void> _handleSend() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    widget.onCodeSent?.call(_emailCtrl.text.trim());
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final onSurface = isDark ? AppColors.onSurfaceDark : AppColors.onSurfaceLight;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        appBar: CustomAppBar(title: context.tr('forgot_password')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(
                  child: Container(
                    width: 88, height: 88,
                    decoration: BoxDecoration(
                      color: AppColors.primary.withValues(alpha: 0.10),
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(Icons.lock_reset_rounded, color: AppColors.primary, size: 42),
                  ),
                ),
                const SizedBox(height: 32),
                Text(context.tr('forgot_password_title'),
                  style: AppTextStyles.textTheme.headlineSmall?.copyWith(
                    color: onSurface, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
                const SizedBox(height: 8),
                Text(context.tr('forgot_password_subtitle'),
                  style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                    color: onSurface.withValues(alpha: 0.58), height: 1.55)),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _emailCtrl,
                  labelText: context.tr('email'),
                  hintText: context.tr('email_hint'),
                  type: TextFieldType.email,
                  isRequired: true,
                  prefixIcon: const Icon(Icons.email_outlined),
                  textInputAction: TextInputAction.done,
                  onSubmitted: (_) => _handleSend(),
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: context.tr('send_code'),
                  onPressed: _handleSend,
                  isLoading: _isLoading,
                  icon: Icons.send_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
