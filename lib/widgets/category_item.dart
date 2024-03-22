import 'package:flutter/material.dart';
import 'package:recipe_app/common/app_routes.dart';
import 'package:recipe_app/models/category.dart';

class CategoryItem extends StatelessWidget {
  final Category category;

  const CategoryItem({
    required this.category,
    super.key,
  });

  void _selectCategory(BuildContext context, Category category) {
    Navigator.of(context).pushNamed(
      AppRoutes.CATEGORIES_MEALS,
      arguments: category,
    );

    // Navigator.of(context).push(MaterialPageRoute(builder: (_) {
    //   return CategoriesMealsScreen(category: category);
    // }));
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: () => _selectCategory(
        context,
        category,
      ),
      borderRadius: BorderRadius.circular(15),
      splashColor: Theme.of(context).colorScheme.shadow,
      highlightColor: Theme.of(context).colorScheme.shadow,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(15),
          gradient: LinearGradient(
            colors: [
              category.color.withOpacity(0.5),
              category.color,
            ],
          ),
        ),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 10,
            top: 5,
          ),
          child: Text(
            category.title,
            style: Theme.of(context).textTheme.bodyLarge,
          ),
        ),
      ),
    );
  }
}
