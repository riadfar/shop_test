import 'package:flutter/material.dart';
import '../../../../data/models/food_item_model.dart';
import 'food_item_card.dart';
import 'section_title.dart';

class FoodSection extends StatelessWidget {
  final String title;
  final List<FoodItemModel> items;
  const FoodSection({super.key, required this.title, required this.items});

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SectionTitle(title: title, onSeeAll: () {}),
        const SizedBox(height: 12),
        SizedBox(
          height: 250,
          child: ListView.builder(
            scrollDirection: Axis.horizontal,
            padding: const EdgeInsetsDirectional.only(start: 16, end: 8),
            itemCount: items.length,
            itemBuilder: (_, i) => FoodItemCard(item: items[i]),
          ),
        ),
      ],
    );
  }
}
