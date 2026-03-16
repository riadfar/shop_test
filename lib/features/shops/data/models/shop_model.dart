import '../../domain/entities/shop.dart';

class ShopModel extends Shop {
  const ShopModel({
    required super.id,
    required super.nameEn,
    required super.nameAr,
    required super.descriptionEn,
    required super.descriptionAr,
    required super.estimatedDeliveryTime,
    required super.minimumOrderAmount,
    required super.minimumOrderCurrency,
    super.deliveryFee = 0.0,
    required super.city,
    required super.country,
    required super.availability,
    required super.coverPhoto,
    required super.profilePhoto,
    required super.categoryType,
    required super.badgeTag,
  });

  factory ShopModel.fromJson(Map<String, dynamic> json) {
    final shopName = json['shopName'] as Map<String, dynamic>? ?? {};
    final description = json['description'] as Map<String, dynamic>? ?? {};
    final minimumOrder = json['minimumOrder'] as Map<String, dynamic>? ?? {};
    final address = json['address'] as Map<String, dynamic>? ?? {};

    return ShopModel(
      id: json['_id'] as String? ?? '',
      nameEn: shopName['en'] as String? ?? '',
      nameAr: shopName['ar'] as String? ?? '',
      descriptionEn: description['en'] as String? ?? '',
      descriptionAr: description['ar'] as String? ?? '',
      estimatedDeliveryTime: json['estimatedDeliveryTime'] as String? ?? '',
      minimumOrderAmount: (minimumOrder['amount'] as num?)?.toDouble() ?? 0.0,
      minimumOrderCurrency: minimumOrder['currency'] as String? ?? '',
      deliveryFee: (json['deliveryFee'] as num?)?.toDouble() ?? 0.0,
      city: address['city'] as String? ?? '',
      country: address['country'] as String? ?? '',
      availability: json['availability'] as bool? ?? false,
      coverPhoto: json['coverPhoto'] as String? ?? '',
      profilePhoto: json['profilePhoto'] as String? ?? '',
      categoryType: json['categoryType'] as String? ?? '',
      badgeTag: json['badgeTag'] as String? ?? '',
    );
  }
}