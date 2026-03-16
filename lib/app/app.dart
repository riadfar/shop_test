import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:rightware_test/features/shops/presentation/bloc/shop_bloc.dart';
import '../core/theme/theme_manager.dart';
import '../core/localization/app_localizations.dart';
import '../core/localization/dynamic_scaling.dart';
import '../features/splash/presentation/splash_screen.dart';
import '../features/authentication/presentation/pages/login_screen.dart';
import '../features/authentication/presentation/pages/sign_up_screen.dart';
import '../features/authentication/presentation/pages/forgot_password_screen.dart';
import '../features/authentication/presentation/pages/otp_screen.dart';
import '../features/authentication/presentation/pages/reset_password_screen.dart';
import '../features/home/presentation/screens/main_scaffold.dart';

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();

  static void setLocale(BuildContext context, Locale newLocale) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setLocale(newLocale);
  }

  static void setTheme(BuildContext context, AppTheme newTheme) {
    _MyAppState? state = context.findAncestorStateOfType<_MyAppState>();
    state?.setTheme(newTheme);
  }
}

class _MyAppState extends State<MyApp> {
  Locale _locale = const Locale('en', 'US');
  AppTheme _theme = AppTheme.light;
  final ThemeManager _themeManager = ThemeManager();

  void setLocale(Locale locale) {
    setState(() {
      _locale = locale;
    });
  }

  void setTheme(AppTheme theme) {
    setState(() {
      _theme = theme;
    });
  }

  @override
  Widget build(BuildContext context) {
    return DynamicTextScaling(
      child: MaterialApp(
        title: 'Flutter Clean Architecture',
        debugShowCheckedModeBanner: false,
        theme: _themeManager.getTheme(_theme),
        locale: _locale,
        supportedLocales: AppLocalizations.supportedLocales,
        localizationsDelegates: AppLocalizations.localizationsDelegates,
        home: const _SplashEntry(),
        routes: {
          '/login': (context) => const _LoginEntry(),
          '/sign-up': (context) => const _SignUpEntry(),
          '/home': (context) => const MainScaffold(),
          '/forgot-password': (context) => const _ForgotPasswordEntry(),
          '/otp': (context) => const _OtpEntry(),
          '/reset-password': (context) => const _ResetPasswordEntry(),
        },
      ),
    );
  }
}

// ---------------------------------------------------------------------------
// Route entry wrappers — wire navigation callbacks to named routes.
// ---------------------------------------------------------------------------

class _SplashEntry extends StatelessWidget {
  const _SplashEntry();

  @override
  Widget build(BuildContext context) {
    return SplashScreen(
      onAnimationComplete: () {
        Navigator.of(context).pushReplacementNamed('/login');
      },
    );
  }
}

class _LoginEntry extends StatelessWidget {
  const _LoginEntry();

  @override
  Widget build(BuildContext context) {
    return LoginScreen(
      onLogin: () => Navigator.of(context).pushReplacementNamed('/home'),
      onForgotPassword: () =>
          Navigator.of(context).pushNamed('/forgot-password'),
      onSignUp: () => Navigator.of(context).pushNamed('/sign-up'),
    );
  }
}

class _SignUpEntry extends StatelessWidget {
  const _SignUpEntry();

  @override
  Widget build(BuildContext context) {
    return SignUpScreen(
      onSignUp: () => Navigator.of(context).pushReplacementNamed('/home'),
      onLogin: () => Navigator.of(context).pop(),
    );
  }
}

class _ForgotPasswordEntry extends StatelessWidget {
  const _ForgotPasswordEntry();

  @override
  Widget build(BuildContext context) {
    return ForgotPasswordScreen(
      onCodeSent: (email) =>
          Navigator.of(context).pushNamed('/otp', arguments: email),
    );
  }
}

class _OtpEntry extends StatelessWidget {
  const _OtpEntry();

  @override
  Widget build(BuildContext context) {
    final email = ModalRoute.of(context)?.settings.arguments as String? ?? '';
    return OtpScreen(
      email: email,
      onVerified: (email) =>
          Navigator.of(context).pushNamed('/reset-password', arguments: email),
    );
  }
}

class _ResetPasswordEntry extends StatelessWidget {
  const _ResetPasswordEntry();

  @override
  Widget build(BuildContext context) {
    return ResetPasswordScreen(
      onReset: () =>
          Navigator.of(context).pushNamedAndRemoveUntil('/login', (r) => false),
    );
  }
}
