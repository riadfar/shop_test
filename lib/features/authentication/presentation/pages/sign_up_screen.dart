import 'package:flutter/material.dart';

import '../../../../core/localization/app_localizations.dart';
import '../../../../core/theme/app_colors.dart';
import '../../../../core/widgets/atomic/custom_app_bar.dart';
import '../widgets/sign_up_form_body.dart';


class SignUpScreen extends StatefulWidget {
  final VoidCallback? onSignUp;
  final VoidCallback? onLogin;
  const SignUpScreen({super.key, this.onSignUp, this.onLogin});
  @override State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen>
    with SingleTickerProviderStateMixin {
  final _formKey = GlobalKey<FormState>();
  final _firstNameCtrl = TextEditingController();
  final _lastNameCtrl  = TextEditingController();
  final _phoneCtrl     = TextEditingController();
  final _emailCtrl     = TextEditingController();
  final _passwordCtrl  = TextEditingController();
  final _confirmCtrl   = TextEditingController();
  final _addressCtrl   = TextEditingController();
  bool _isLoading = false;
  late final AnimationController _entranceCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _entranceCtrl = AnimationController(vsync: this, duration: const Duration(milliseconds: 520));
    _fadeAnim = CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(CurvedAnimation(parent: _entranceCtrl, curve: Curves.easeOutCubic));
    _entranceCtrl.forward();
  }

  @override
  void dispose() {
    _entranceCtrl.dispose();
    for (final c in [_firstNameCtrl, _lastNameCtrl, _phoneCtrl, _emailCtrl,
        _passwordCtrl, _confirmCtrl, _addressCtrl]) { c.dispose(); }
    super.dispose();
  }

  Future<void> _handleSignUp() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);
    await Future.delayed(const Duration(seconds: 2));
    if (!mounted) return;
    setState(() => _isLoading = false);
    widget.onSignUp?.call();
  }

  String? _validatePassword(String? v) {
    if (v == null || v.trim().isEmpty) return context.tr('field_required');
    return v.length < 8 ? context.tr('password_too_short') : null;
  }

  String? _validateConfirmPassword(String? v) {
    if (v == null || v.trim().isEmpty) return context.tr('field_required');
    return v != _passwordCtrl.text ? context.tr('passwords_dont_match') : null;
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return GestureDetector(
      onTap: () => FocusScope.of(context).unfocus(),
      behavior: HitTestBehavior.opaque,
      child: Scaffold(
        backgroundColor: isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
        appBar: CustomAppBar(
          title: context.tr('create_account'),
        ),
        body: FadeTransition(
          opacity: _fadeAnim,
          child: SlideTransition(
            position: _slideAnim,
            child: SignUpFormBody(
              formKey: _formKey,
              firstNameCtrl: _firstNameCtrl, lastNameCtrl: _lastNameCtrl,
              phoneCtrl: _phoneCtrl, emailCtrl: _emailCtrl,
              passwordCtrl: _passwordCtrl, confirmPasswordCtrl: _confirmCtrl,
              addressCtrl: _addressCtrl, isLoading: _isLoading,
              passwordValidator: _validatePassword,
              confirmPasswordValidator: _validateConfirmPassword,
              onSignUp: _handleSignUp, onLogin: widget.onLogin,
            ),
          ),
        ),
      ),
    );
  }
}
