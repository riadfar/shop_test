import 'package:flutter/material.dart';
import '../../../core/theme/app_colors.dart';
import 'models/category_model.dart';
import 'models/food_item_model.dart';
import 'models/promo_banner_model.dart';

class DummyData {
  DummyData._();

  static const List<CategoryModel> categories = [
    CategoryModel(nameEn: 'All', nameAr: 'الكل', icon: Icons.apps_rounded, color: AppColors.primary),
    CategoryModel(nameEn: 'Pizza',    nameAr: 'بيتزا',   icon: Icons.local_pizza_rounded,    color: Color(0xFFFF7043)),
    CategoryModel(nameEn: 'Burgers',  nameAr: 'برغر',    icon: Icons.lunch_dining_rounded,   color: Color(0xFFE53935)),
    CategoryModel(nameEn: 'Sushi',    nameAr: 'سوشي',    icon: Icons.set_meal_rounded,       color: Color(0xFF00897B)),
    CategoryModel(nameEn: 'Drinks',   nameAr: 'مشروبات', icon: Icons.local_bar_rounded,      color: Color(0xFF1E88E5)),
    CategoryModel(nameEn: 'Salads',   nameAr: 'سلطات',   icon: Icons.eco_rounded,            color: Color(0xFF43A047)),
    CategoryModel(nameEn: 'Desserts', nameAr: 'حلويات',  icon: Icons.cake_rounded,           color: Color(0xFFEC407A)),
  ];

  static const List<FoodItemModel> popularItems = [
    FoodItemModel(nameEn: 'Double Smash Burger & Truffle Fries', nameAr: 'برغر سماش مزدوج مع بطاطس كمأة', restaurantEn: 'The Smash Lab',    restaurantAr: 'ذا سماش لاب',   price: 18.99, rating: 4.8, deliveryMinutes: 25, imagePath: 'assets/images/burger.png'),
    FoodItemModel(nameEn: 'Spicy Dynamite Salmon Roll',          nameAr: 'رولة سالمون دينامايت حارة',     restaurantEn: 'Sakura Omakase',   restaurantAr: 'ساكورا أوماكاسي', price: 21.99, rating: 4.9, deliveryMinutes: 35, imagePath: 'assets/images/sushi.png'),
    FoodItemModel(nameEn: 'Creamy Truffle Margherita',           nameAr: 'بيتزا مارغريتا كريمية بالكمأة', restaurantEn: 'Forno Napoli',     restaurantAr: 'فورنو نابولي',  price: 19.99, rating: 4.8, deliveryMinutes: 30, imagePath: 'assets/images/pizza.png'),
    FoodItemModel(nameEn: 'Mango Yuzu Smoothie Bowl',            nameAr: 'بول سموزي المانجو واليوزو',     restaurantEn: 'Bloom Kitchen',    restaurantAr: 'بلوم كيتشن',    price: 14.99, rating: 4.7, deliveryMinutes: 15, imagePath: 'assets/images/mango.png'),
  ];

  static const List<FoodItemModel> trendingItems = [
    FoodItemModel(nameEn: 'Korean Crispy Fried Chicken',  nameAr: 'دجاج كوري مقلي مقرمش',         restaurantEn: 'Seoul Bites',         restaurantAr: 'سيول بايتس',       price: 16.99, rating: 4.8, deliveryMinutes: 28, imagePath: 'assets/images/chicken.png'),
    FoodItemModel(nameEn: 'Wagyu Beef Smash Burger',      nameAr: 'برغر سماش لحم واغو',           restaurantEn: 'The Smash Lab',       restaurantAr: 'ذا سماش لاب',       price: 22.99, rating: 4.9, deliveryMinutes: 25, imagePath: 'assets/images/burger.png'),
    FoodItemModel(nameEn: 'Lychee Rose Crêpe Stack',      nameAr: 'كريب الليتشي والورد',          restaurantEn: 'Pâtisserie Blanche', restaurantAr: 'باتيسيري بلانش',    price: 13.99, rating: 4.7, deliveryMinutes: 30, imagePath: 'assets/images/crepe.png'),
    FoodItemModel(nameEn: 'Salted Caramel Matcha Shake',  nameAr: 'شيك ماتشا بالكراميل المملح',   restaurantEn: 'Bloom Kitchen',       restaurantAr: 'بلوم كيتشن',        price: 12.99, rating: 4.8, deliveryMinutes: 15, imagePath: 'assets/images/milkshake.png'),
  ];

  static const List<PromoBannerModel> banners = [
    PromoBannerModel(titleEn: '50% OFF First Order', titleAr: '٥٠٪ خصم على أول طلب', subtitleEn: 'Use code FLAVOR50', subtitleAr: 'استخدم كود FLAVOR50', colorStart: Color(0xFFFF4B3A), colorEnd: Color(0xFFFF8A65), icon: Icons.local_offer_rounded),
    PromoBannerModel(titleEn: 'Free Delivery on \$30+', titleAr: 'توصيل مجاني لطلبات +٣٠\$', subtitleEn: 'No minimum on weekends', subtitleAr: 'لا حد أدنى في عطل نهاية الأسبوع', colorStart: Color(0xFF1E88E5), colorEnd: Color(0xFF42A5F5), icon: Icons.delivery_dining_rounded),
    PromoBannerModel(titleEn: 'Sushi Night Special 🍣', titleAr: 'ليلة السوشي المميزة 🍣', subtitleEn: 'Every Tuesday — 20% off', subtitleAr: 'كل ثلاثاء — خصم ٢٠٪', colorStart: Color(0xFF00897B), colorEnd: Color(0xFF26A69A), icon: Icons.set_meal_rounded),
  ];
}
