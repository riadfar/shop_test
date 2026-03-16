import 'package:flutter/material.dart';
import 'models/category_model.dart';
import 'models/food_item_model.dart';
import 'models/promo_banner_model.dart';

class DummyData {
  DummyData._();

  static const List<CategoryModel> categories = [
    CategoryModel(nameEn: 'Pizza',    nameAr: 'بيتزا',   icon: Icons.local_pizza_rounded,    color: Color(0xFFFF7043)),
    CategoryModel(nameEn: 'Burgers',  nameAr: 'برغر',    icon: Icons.lunch_dining_rounded,   color: Color(0xFFE53935)),
    CategoryModel(nameEn: 'Sushi',    nameAr: 'سوشي',    icon: Icons.set_meal_rounded,       color: Color(0xFF00897B)),
    CategoryModel(nameEn: 'Drinks',   nameAr: 'مشروبات', icon: Icons.local_bar_rounded,      color: Color(0xFF1E88E5)),
    CategoryModel(nameEn: 'Salads',   nameAr: 'سلطات',   icon: Icons.eco_rounded,            color: Color(0xFF43A047)),
    CategoryModel(nameEn: 'Desserts', nameAr: 'حلويات',  icon: Icons.cake_rounded,           color: Color(0xFFEC407A)),
  ];

  static const List<FoodItemModel> popularItems = [
    FoodItemModel(nameEn: 'Pepperoni Pizza', nameAr: 'بيتزا بيبروني', restaurantEn: "Mario's",     restaurantAr: 'ماريو',     price: 14.99, rating: 4.8, deliveryMinutes: 25, imagePath: 'assets/images/pizza.png'),
    FoodItemModel(nameEn: 'Classic Burger',  nameAr: 'برغر كلاسيك',  restaurantEn: 'Burger Bros',  restaurantAr: 'برغر برز', price: 9.99,  rating: 4.6, deliveryMinutes: 20, imagePath: 'assets/images/burger.png'),
    FoodItemModel(nameEn: 'Salmon Roll',     nameAr: 'رولة سالمون',  restaurantEn: 'Sakura',       restaurantAr: 'ساكورا',   price: 18.99, rating: 4.9, deliveryMinutes: 35, imagePath: 'assets/images/sushi.png'),
    FoodItemModel(nameEn: 'Mango Shake',     nameAr: 'شيك منجو',     restaurantEn: 'Juice World',  restaurantAr: 'جوس ورلد', price: 6.99,  rating: 4.4, deliveryMinutes: 12, imagePath: 'assets/images/mango.png'),
  ];

  static const List<FoodItemModel> trendingItems = [
    FoodItemModel(nameEn: 'Caesar Salad',   nameAr: 'سلطة سيزر',      restaurantEn: 'Garden Fresh', restaurantAr: 'جاردن',     price: 11.99, rating: 4.7, deliveryMinutes: 20, imagePath: 'assets/images/salad.png'),
    FoodItemModel(nameEn: 'Crispy Chicken', nameAr: 'دجاج مقرمش',     restaurantEn: 'Grill House',  restaurantAr: 'جريل هاوس', price: 13.99, rating: 4.7, deliveryMinutes: 28, imagePath: 'assets/images/chicken.png'),
    FoodItemModel(nameEn: 'Sweet Crepe',    nameAr: 'كريب حلو',       restaurantEn: 'Sweet Tooth',  restaurantAr: 'سويت',      price: 8.99,  rating: 4.8, deliveryMinutes: 30, imagePath: 'assets/images/crepe.png'),
    FoodItemModel(nameEn: 'Milk Shake',     nameAr: 'ميلك شيك',       restaurantEn: 'Shake Bar',    restaurantAr: 'شيك بار',   price: 7.49,  rating: 4.5, deliveryMinutes: 15, imagePath: 'assets/images/milkshake.png'),
  ];

  static const List<PromoBannerModel> banners = [
    PromoBannerModel(titleEn: '50% OFF First Order', titleAr: '٥٠٪ خصم على أول طلب', subtitleEn: 'Use code FLAVOR50', subtitleAr: 'استخدم كود FLAVOR50', colorStart: Color(0xFFFF4B3A), colorEnd: Color(0xFFFF8A65), icon: Icons.local_offer_rounded),
    PromoBannerModel(titleEn: 'Free Delivery on \$30+', titleAr: 'توصيل مجاني لطلبات +٣٠\$', subtitleEn: 'No minimum on weekends', subtitleAr: 'لا حد أدنى في عطل نهاية الأسبوع', colorStart: Color(0xFF1E88E5), colorEnd: Color(0xFF42A5F5), icon: Icons.delivery_dining_rounded),
    PromoBannerModel(titleEn: 'Sushi Night Special 🍣', titleAr: 'ليلة السوشي المميزة 🍣', subtitleEn: 'Every Tuesday — 20% off', subtitleAr: 'كل ثلاثاء — خصم ٢٠٪', colorStart: Color(0xFF00897B), colorEnd: Color(0xFF26A69A), icon: Icons.set_meal_rounded),
  ];
}
