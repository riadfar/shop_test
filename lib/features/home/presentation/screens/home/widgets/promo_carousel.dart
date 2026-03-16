import 'dart:async';
import 'package:flutter/material.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../data/models/promo_banner_model.dart';
import 'promo_banner_card.dart';

class PromoCarousel extends StatefulWidget {
  final List<PromoBannerModel> banners;
  const PromoCarousel({super.key, required this.banners});
  @override State<PromoCarousel> createState() => _PromoCarouselState();
}

class _PromoCarouselState extends State<PromoCarousel> {
  late final PageController _ctrl;
  Timer _timer = Timer(Duration.zero, () {});
  int _current = 0;

  @override
  void initState() {
    super.initState();
    _ctrl = PageController(viewportFraction: 0.88);
    _timer = Timer.periodic(const Duration(seconds: 3), (_) {
      final next = (_current + 1) % widget.banners.length;
      _ctrl.animateToPage(next, duration: const Duration(milliseconds: 400), curve: Curves.easeInOut);
    });
  }

  @override
  void dispose() { _timer.cancel(); _ctrl.dispose(); super.dispose(); }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        SizedBox(
          height: 150,
          child: PageView.builder(
            controller: _ctrl,
            itemCount: widget.banners.length,
            onPageChanged: (i) => setState(() => _current = i),
            itemBuilder: (_, i) => PromoBannerCard(banner: widget.banners[i]),
          ),
        ),
        const SizedBox(height: 10),
        Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: List.generate(widget.banners.length, (i) => AnimatedContainer(
            duration: const Duration(milliseconds: 250),
            margin: const EdgeInsets.symmetric(horizontal: 3),
            width: _current == i ? 18.0 : 6.0,
            height: 6,
            decoration: BoxDecoration(
              color: _current == i ? AppColors.primary : AppColors.borderLight,
              borderRadius: BorderRadius.circular(3),
            ),
          )),
        ),
      ],
    );
  }
}
