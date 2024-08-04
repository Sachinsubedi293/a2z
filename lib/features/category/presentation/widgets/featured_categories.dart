import 'package:flutter/material.dart';
import 'featured_category_item.dart';

class FeaturedCategories extends StatelessWidget {
  final List<Map<String, String>> featuredCategories;

  FeaturedCategories({required this.featuredCategories});

  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: List.generate(featuredCategories.length, (index) {
          return FeaturedCategoryItem(
            title: featuredCategories[index]['title']!,
            imageUrl: featuredCategories[index]['imageUrl']!,
          );
        }),
      ),
    );
  }
}
