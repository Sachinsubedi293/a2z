// widgets/category_row.dart
import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: [
        CategoryItem(title: 'Women', icon: Icons.woman),
        CategoryItem(title: 'Men', icon: Icons.man),
        CategoryItem(title: 'Accessories', icon: Icons.watch),
        CategoryItem(title: 'Beauty', icon: Icons.brush),
      ],
    );
  }
}

class CategoryItem extends StatelessWidget {
  final String title;
  final IconData icon;

  const CategoryItem({required this.title, required this.icon});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Icon(icon, size: 32),
        Text(title),
      ],
    );
  }
}
