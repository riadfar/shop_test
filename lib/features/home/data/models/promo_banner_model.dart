import 'package:flutter/material.dart';

class PromoBannerModel {
  final String titleEn;
  final String titleAr;
  final String subtitleEn;
  final String subtitleAr;
  final Color colorStart;
  final Color colorEnd;
  final IconData icon;

  const PromoBannerModel({
    required this.titleEn,
    required this.titleAr,
    required this.subtitleEn,
    required this.subtitleAr,
    required this.colorStart,
    required this.colorEnd,
    required this.icon,
  });
}
