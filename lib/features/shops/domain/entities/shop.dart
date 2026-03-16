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
  final double deliveryFee;
  final String city;
  final String state;
  final String street;
  final String otherDetails;
  final String country;
  final bool availability;
  final String coverPhoto;
  final String profilePhoto;
  final String categoryType;
  final String badgeTag;
  final List<String> contactInfo;
  final List<String> deliveryRegions;

  const Shop({
    required this.id,
    required this.nameEn,
    required this.nameAr,
    required this.descriptionEn,
    required this.descriptionAr,
    required this.estimatedDeliveryTime,
    required this.minimumOrderAmount,
    required this.minimumOrderCurrency,
    this.deliveryFee = 0.0,
    required this.city,
    this.state = '',
    this.street = '',
    this.otherDetails = '',
    required this.country,
    required this.availability,
    required this.coverPhoto,
    required this.profilePhoto,
    required this.categoryType,
    required this.badgeTag,
    this.contactInfo = const [],
    this.deliveryRegions = const [],
  });

  @override
  List<Object?> get props => [
        id, nameEn, nameAr, descriptionEn, descriptionAr,
        estimatedDeliveryTime, minimumOrderAmount, minimumOrderCurrency,
        deliveryFee, city, state, street, otherDetails, country,
        availability, coverPhoto, profilePhoto, categoryType, badgeTag,
        contactInfo, deliveryRegions,
      ];
}