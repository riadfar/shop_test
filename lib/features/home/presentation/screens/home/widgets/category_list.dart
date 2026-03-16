import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../../../core/theme/app_colors.dart';
import '../../../../../../core/theme/app_text_styles.dart';
import '../../../../data/models/category_model.dart';
import '../../../../../shops/presentation/bloc/shop_bloc.dart';
import '../../../../../shops/presentation/bloc/shop_event.dart';

class CategoryList extends StatefulWidget {
  final List<CategoryModel> categories;
  const CategoryList({super.key, required this.categories});
  @override State<CategoryList> createState() => _CategoryListState();
}

class _CategoryListState extends State<CategoryList> {
  int _selected = 0;

  @override
  Widget build(BuildContext context) {
    final isAr = Localizations.localeOf(context).languageCode == 'ar';
    return SizedBox(
      height: 90,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 6),
        itemCount: widget.categories.length,
        itemBuilder: (_, i) => _CategoryItem(
          category: widget.categories[i],
          isSelected: _selected == i,
          isAr: isAr,
          onTap: () {
            setState(() => _selected = i);
            if (i == 0) {
              context.read<ShopBloc>().add(const ClearFilters());
            }
          },
        ),
      ),
    );
  }
}

class _CategoryItem extends StatelessWidget {
  final CategoryModel category;
  final bool isSelected;
  final bool isAr;
  final VoidCallback onTap;
  const _CategoryItem({required this.category, required this.isSelected, required this.isAr, required this.onTap});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: 72,
        margin: const EdgeInsets.symmetric(horizontal: 4),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            AnimatedContainer(
              duration: const Duration(milliseconds: 200),
              width: 52, height: 52,
              decoration: BoxDecoration(
                color: isSelected ? category.color : category.color.withValues(alpha: 0.12),
                shape: BoxShape.circle,
                boxShadow: isSelected ? [BoxShadow(color: category.color.withValues(alpha: 0.4), blurRadius: 10, offset: const Offset(0, 4))] : null,
              ),
              child: Icon(category.icon, size: 24, color: isSelected ? AppColors.onPrimary : category.color),
            ),
            const SizedBox(height: 5),
            Text(isAr ? category.nameAr : category.nameEn,
              style: AppTextStyles.textTheme.bodySmall?.copyWith(
                fontSize: 11, fontWeight: isSelected ? FontWeight.w700 : FontWeight.w400,
                color: isSelected ? category.color : AppColors.iconLight),
              textAlign: TextAlign.center, maxLines: 1, overflow: TextOverflow.ellipsis),
          ],
        ),
      ),
    );
  }
}
