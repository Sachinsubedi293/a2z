import 'package:flutter/material.dart';
import 'category_item.dart';

class CategoriesGrid extends StatelessWidget {
  final List<Map<String, String>> categories;

  const CategoriesGrid({super.key, required this.categories});

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: GridView.count(
        crossAxisCount: 2,
        crossAxisSpacing: 16,
        mainAxisSpacing: 16,
        children: List.generate(categories.length, (index) {
          return CategoryItem(
            title: categories[index]['title']!,
            imageUrl: categories[index]['imageUrl']!,
          );
        }),
      ),
    );
  }
}
