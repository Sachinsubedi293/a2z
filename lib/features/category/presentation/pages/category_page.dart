import 'package:a2zjewelry/features/category/presentation/widgets/categories_grid.dart';
import 'package:a2zjewelry/features/category/presentation/widgets/featured_categories.dart';
import 'package:a2zjewelry/features/category/presentation/widgets/search_bar.dart';
import 'package:a2zjewelry/features/category/presentation/widgets/section_title.dart';
import 'package:flutter/material.dart';


class CategoriesPage extends StatelessWidget {
  final List<Map<String, String>> _categories = [
    {'title': 'Necklaces', 'imageUrl': 'https://example.com/necklaces.jpg'},
    {'title': 'Rings', 'imageUrl': 'https://example.com/rings.jpg'},
    {'title': 'Bracelets', 'imageUrl': 'https://example.com/bracelets.jpg'},
    {'title': 'Earrings', 'imageUrl': 'https://example.com/earrings.jpg'},
  ];

  final List<Map<String, String>> _featuredCategories = [
    {'title': 'Gold Jewelry', 'imageUrl': 'https://example.com/gold.jpg'},
    {'title': 'Silver Jewelry', 'imageUrl': 'https://example.com/silver.jpg'},
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            SearchBarCategory(
              onChanged: (value) {
              },
            ),
            SizedBox(height: 16),
            SectionTitle(title: 'Categories'),
            SizedBox(height: 16),
            CategoriesGrid(categories: _categories),
            SizedBox(height: 16),
            SectionTitle(title: 'Featured'),
            SizedBox(height: 16),
            FeaturedCategories(featuredCategories: _featuredCategories),
          ],
        ),
      ),
    );
  }
}
