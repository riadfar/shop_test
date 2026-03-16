import 'package:flutter/material.dart';
import 'package:rightware_test/core/localization/app_localizations.dart';

import '../../../../core/theme/app_colors.dart';
import '../widgets/form_section.dart';
import '../widgets/hero_section.dart';
import '../widgets/language_toggle.dart';

class LoginScreen extends StatefulWidget {
  final VoidCallback? onLogin;
  final VoidCallback? onForgotPassword;
  final VoidCallback? onSignUp;

  const LoginScreen({
    super.key,
    this.onLogin,
    this.onForgotPassword,
    this.onSignUp,
  });

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen>
    with SingleTickerProviderStateMixin {

  static const String _appLogoAsset = 'assets/icons/logo.svg';

  final _formKey = GlobalKey<FormState>();
  final _emailCtrl = TextEditingController();
  final _passwordCtrl = TextEditingController();
  bool _isLoading = false;

  late final AnimationController _fadeCtrl;
  late final Animation<double> _fadeAnim;
  late final Animation<Offset> _slideAnim;

  @override
  void initState() {
    super.initState();
    _fadeCtrl = AnimationController(
        vsync: this, duration: const Duration(milliseconds: 520));
    _fadeAnim = CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOut);
    _slideAnim = Tween<Offset>(begin: const Offset(0, 0.06), end: Offset.zero)
        .animate(
            CurvedAnimation(parent: _fadeCtrl, curve: Curves.easeOutCubic));

    WidgetsBinding.instance.addPostFrameCallback((_) => _fadeCtrl.forward());
  }

  @override
  void dispose() {
    _fadeCtrl.dispose();
    _emailCtrl.dispose();
    _passwordCtrl.dispose();
    super.dispose();
  }

  Future<void> _handleLogin() async {
    FocusScope.of(context).unfocus();
    if (!_formKey.currentState!.validate()) return;
    setState(() => _isLoading = true);

    await Future.delayed(const Duration(seconds: 2)); // TODO: Actual auth call

    if (mounted) {
      setState(() => _isLoading = false);
      widget.onLogin?.call();
    }
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final bgColor =
        isDark ? AppColors.backgroundDark : AppColors.backgroundLight;
    String appName= context.tr('app_title');
    String appSubtitle= context.tr('app_subtitle');
    return Scaffold(
      extendBodyBehindAppBar: true,
      backgroundColor: bgColor,
      body: Stack(
        alignment: Alignment.topLeft,
        children: [
          GestureDetector(
            onTap: () => FocusScope.of(context).unfocus(),
            behavior: HitTestBehavior.opaque,
            child: SingleChildScrollView(
              physics: const ClampingScrollPhysics(),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.stretch,
                children: [
                  HeroSection(appName: appName, appSubtitle: appSubtitle, appLogo: _appLogoAsset),
                  FadeTransition(
                    opacity: _fadeAnim,
                    child: SlideTransition(
                      position: _slideAnim,
                      child: FormSection(
                        formKey: _formKey, emailCtrl: _emailCtrl, passwordCtrl: _passwordCtrl,
                        isLoading: _isLoading, isDark: isDark, onLogin: _handleLogin,
                        onForgotPassword: widget.onForgotPassword, onSignUp: widget.onSignUp,
                      ),
                    ),
                  ),
                ],
              ),
            ),
          ),
          const Padding(
            padding: EdgeInsets.fromLTRB(24,38,0,0),
            child: LanguageToggleButton(),
          ),
        ],
      ),
    );
  }
}
