// widgets/recommended_products.dart
import 'package:flutter/material.dart';
import 'product_item.dart';

class RecommendedProducts extends StatelessWidget {
  const RecommendedProducts({super.key});

  @override
  Widget build(BuildContext context) {
    return const SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ProductItem(title: 'White fashion hoodie', price: 29.00, imageUrl: 'https://example.com/white_fashion_hoodie.jpg'),
          ProductItem(title: 'Cotton T-Shirt', price: 30.00, imageUrl: 'https://example.com/cotton_tshirt.jpg'),
        ],
      ),
    );
  }
}
