import 'package:equatable/equatable.dart';

class Shop extends Equatable {
  final String id;
  final String nameEn;
  final String nameAr;
  final String descriptionEn;
  final String descriptionAr;
  final String estimatedDeliveryTime;
  final double minimumOrderAmount;
  final String minimumOrderCurrency;
  final String city;
  final String country;
  final bool availability;
  final String coverPhoto;
  final String profilePhoto;
  final String categoryType;
  final String badgeTag;

  const Shop({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.estimatedDeliveryTime,
    required this.minimumOrderAmount,
    required this.minimumOrderCurrency,
    required this.city,
    required this.country,
    required this.availability,
    required this.coverPhoto,
    required this.profilePhoto,
    required this.categoryType,
    required this.badgeTag,
  });

  @override
  List<Object?> get props => [
        id,
        nameEn,
        nameAr,
        descriptionEn,
        descriptionAr,
        estimatedDeliveryTime,
        minimumOrderAmount,
        minimumOrderCurrency,
        city,
        country,
        availability,
        coverPhoto,
        profilePhoto,
        categoryType,
        badgeTag,
      ];
}
