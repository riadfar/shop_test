import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/theme/app_text_styles.dart';
import '../../../../core/widgets/atomic/custom_app_bar.dart';
import '../../../../core/widgets/atomic/custom_button.dart';
import '../../../../core/widgets/atomic/custom_text_field.dart';

class ResetPasswordScreen extends StatefulWidget {
  final VoidCallback? onReset;
  const ResetPasswordScreen({super.key, this.onReset});
  @override State<ResetPasswordScreen> createState() => _ResetPasswordScreenState();
}

class _ResetPasswordScreenState extends State<ResetPasswordScreen> {
  final _formKey = GlobalKey<FormState>();
  final _passwordCtrl = TextEditingController();
  final _confirmCtrl = TextEditingController();
  bool _isLoading = false;

  @override
  void dispose() { _passwordCtrl.dispose(); _confirmCtrl.dispose(); super.dispose(); }

  Future<void> _handleReset() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(context.tr('password_reset_success')),
      backgroundColor: AppColors.success,
      behavior: SnackBarBehavior.floating,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
      margin: const EdgeInsets.all(16),
    ));
    await Future.delayed(const Duration(milliseconds: 1200));
    if (!mounted) return;
    widget.onReset?.call();
  }

  String? _validatePw(String? v) {
    if (v == null || v.trim().isEmpty) return context.tr('field_required');
    return v.length < 8 ? context.tr('password_too_short') : null;
  }

  String? _validateConfirm(String? v) {
    if (v == null || v.trim().isEmpty) return context.tr('field_required');
    return v != _passwordCtrl.text ? context.tr('passwords_dont_match') : null;
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
        appBar: CustomAppBar(title: context.tr('reset_password_title')),
        body: SingleChildScrollView(
          padding: const EdgeInsets.fromLTRB(24, 32, 24, 48),
          child: Form(
            key: _formKey,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Center(child: Container(width: 88, height: 88,
                  decoration: BoxDecoration(color: AppColors.primary.withValues(alpha: 0.10), shape: BoxShape.circle),
                  child: const Icon(Icons.lock_open_rounded, color: AppColors.primary, size: 42))),
                const SizedBox(height: 32),
                Text(context.tr('reset_password_title'), style: AppTextStyles.textTheme.headlineSmall?.copyWith(
                  color: onSurface, fontWeight: FontWeight.w800, letterSpacing: -0.4)),
                const SizedBox(height: 8),
                Text(context.tr('reset_password_subtitle'), style: AppTextStyles.textTheme.bodyMedium?.copyWith(
                  color: onSurface.withValues(alpha: 0.58), height: 1.55)),
                const SizedBox(height: 32),
                CustomTextField(
                  controller: _passwordCtrl,
                  labelText: context.tr('new_password'),
                  hintText: context.tr('new_password_hint'),
                  type: TextFieldType.password,
                  isRequired: true,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  textInputAction: TextInputAction.next,
                  validator: _validatePw,
                ),
                const SizedBox(height: 14),
                CustomTextField(
                  controller: _confirmCtrl,
                  labelText: context.tr('confirm_password'),
                  hintText: context.tr('confirm_password_hint'),
                  type: TextFieldType.password,
                  isRequired: true,
                  prefixIcon: const Icon(Icons.lock_outline_rounded),
                  textInputAction: TextInputAction.done,
                  validator: _validateConfirm,
                ),
                const SizedBox(height: 32),
                CustomButton(
                  text: context.tr('reset_password_button'),
                  onPressed: _handleReset,
                  isLoading: _isLoading,
                  icon: Icons.check_circle_outline_rounded,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
