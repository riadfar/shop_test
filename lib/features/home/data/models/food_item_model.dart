class FoodItemModel {
  final String nameEn;
  final String nameAr;
  final String restaurantEn;
  final String restaurantAr;
  final double price;
  final double rating;
  final int deliveryMinutes;
  final String imagePath;

  const FoodItemModel({
    required this.nameEn,
    required this.nameAr,
    required this.restaurantEn,
    required this.restaurantAr,
    required this.price,
    required this.rating,
    required this.deliveryMinutes,
    required this.imagePath,
  });
}
