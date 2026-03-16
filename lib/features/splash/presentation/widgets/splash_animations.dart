import 'package:flutter/material.dart';

class SplashAnimations {
  // Controllers
  late final AnimationController bgCtrl, logoContainerCtrl, logoIconCtrl;
  late final AnimationController particlesCtrl,
      nameCtrl,
      taglineCtrl,
      loaderCtrl;

  // Animations
  late final Animation<double> bgFade, containerScale, containerOpacity;
  late final Animation<double> iconScale, iconRotation, particlesFade;
  late final Animation<double> nameFade, taglineFade;
  late final Animation<Offset> nameSlide;

  SplashAnimations(TickerProvider vsync) {
    _buildControllers(vsync);
    _buildAnimations();
  }

  void _buildControllers(TickerProvider vsync) {
    bgCtrl = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 700));
    logoContainerCtrl = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 650));
    logoIconCtrl = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 750));
    particlesCtrl = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 600));
    nameCtrl = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 550));
    taglineCtrl = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 450));
    loaderCtrl = AnimationController(
        vsync: vsync, duration: const Duration(milliseconds: 1100))
      ..repeat();
  }

  void _buildAnimations() {
    bgFade = CurvedAnimation(parent: bgCtrl, curve: Curves.easeInOut);
    containerScale = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.20)
              .chain(CurveTween(curve: Curves.easeOutCubic)),
          weight: 60),
      TweenSequenceItem(
          tween: Tween(begin: 1.20, end: 0.90)
              .chain(CurveTween(curve: Curves.easeInOut)),
          weight: 20),
      TweenSequenceItem(
          tween: Tween(begin: 0.90, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 20),
    ]).animate(logoContainerCtrl);

    containerOpacity = Tween<double>(begin: 0.0, end: 1.0).animate(
        CurvedAnimation(
            parent: logoContainerCtrl,
            curve: const Interval(0.0, 0.35, curve: Curves.easeIn)));

    iconScale = TweenSequence<double>([
      TweenSequenceItem(
          tween: Tween(begin: 0.0, end: 1.15)
              .chain(CurveTween(curve: Curves.elasticOut)),
          weight: 70),
      TweenSequenceItem(
          tween: Tween(begin: 1.15, end: 1.0)
              .chain(CurveTween(curve: Curves.easeOut)),
          weight: 30),
    ]).animate(logoIconCtrl);

    iconRotation = Tween<double>(begin: -0.35, end: 0.0).animate(
        CurvedAnimation(parent: logoIconCtrl, curve: Curves.elasticOut));
    particlesFade =
        CurvedAnimation(parent: particlesCtrl, curve: Curves.easeOut);
    nameSlide = Tween<Offset>(begin: const Offset(0.0, 0.7), end: Offset.zero)
        .animate(CurvedAnimation(parent: nameCtrl, curve: Curves.easeOutCubic));
    nameFade = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: nameCtrl, curve: Curves.easeOut));
    taglineFade = Tween<double>(begin: 0.0, end: 1.0)
        .animate(CurvedAnimation(parent: taglineCtrl, curve: Curves.easeIn));
  }

  Listenable get listenable => Listenable.merge([
        bgCtrl,
        logoContainerCtrl,
        logoIconCtrl,
        particlesCtrl,
        nameCtrl,
        taglineCtrl,
        loaderCtrl
      ]);

  void dispose() {
    bgCtrl.dispose();
    logoContainerCtrl.dispose();
    logoIconCtrl.dispose();
    particlesCtrl.dispose();
    nameCtrl.dispose();
    taglineCtrl.dispose();
    loaderCtrl.dispose();
  }
}
