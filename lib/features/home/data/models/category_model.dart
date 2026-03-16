import 'package:flutter/material.dart';

class CategoryModel {
  final String nameEn;
  final String nameAr;
  final IconData icon;
  final Color color;

  const CategoryModel({
    required this.nameEn,
    required this.nameAr,
    required this.icon,
    required this.color,
  });
}
