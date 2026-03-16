import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import '../../../core/theme/app_colors.dart';
import 'widgets/splash_background.dart';
import 'widgets/food_particles.dart';
import 'widgets/splash_content.dart';
import 'widgets/splash_animations.dart';

class SplashScreen extends StatefulWidget {
  final VoidCallback? onAnimationComplete;

  const SplashScreen({super.key, this.onAnimationComplete});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen>
    with TickerProviderStateMixin {
  // BRANDING
  static const String _appName = 'FlavorRush';
  static const String _appTagline = 'Crave it. Order it. Love it.';
  static const IconData _appLogoIcon = Icons.local_fire_department_rounded;
  static const String? _appLogoAsset = null;

  late final SplashAnimations _anims;

  @override
  void initState() {
    super.initState();
    SystemChrome.setSystemUIOverlayStyle(const SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      statusBarIconBrightness: Brightness.light,
    ));
    _anims = SplashAnimations(this);
    _runSequence();
  }

  Future<void> _runSequence() async {
    await Future.delayed(const Duration(milliseconds: 120));
    _anims.bgCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 180));
    _anims.logoContainerCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 220));
    _anims.logoIconCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 280));
    _anims.particlesCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 250));
    _anims.nameCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 350));
    _anims.taglineCtrl.forward();
    await Future.delayed(const Duration(milliseconds: 900));

    widget.onAnimationComplete?.call();
    if (mounted && widget.onAnimationComplete == null) {
      Navigator.of(context).pushReplacementNamed('/home');
    }
  }

  @override
  void dispose() {
    _anims.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;

    return Scaffold(
      backgroundColor:
          isDark ? AppColors.backgroundDark : AppColors.backgroundLight,
      body: AnimatedBuilder(
        animation: _anims.listenable,
        builder: (context, _) {
          return Stack(
            fit: StackFit.expand,
            children: [
              SplashBackground(progress: _anims.bgFade.value, isDark: isDark),
              FoodParticles(progress: _anims.particlesFade.value),
              SplashContent(
                anims: _anims,
                appName: _appName,
                appTagline: _appTagline,
                appLogoIcon: _appLogoIcon,
                appLogoAsset: _appLogoAsset,
                isDark: isDark,
              ),
            ],
          );
        },
      ),
    );
  }
}
