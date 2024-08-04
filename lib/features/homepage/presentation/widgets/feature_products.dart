import 'package:flutter/material.dart';
import 'product_item.dart';

class FeatureProducts extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.horizontal,
      child: Row(
        children: [
          ProductItem(title: 'Turtleneck Sweater', price: 39.99, imageUrl: 'https://example.com/turtleneck_sweater.jpg'),
          ProductItem(title: 'Long Sleeve Dress', price: 45.00, imageUrl: 'https://example.com/long_sleeve_dress.jpg'),
          ProductItem(title: 'Sportwear', price: 80.00, imageUrl: 'https://example.com/sportwear.jpg'),
        ],
      ),
    );
  }
}
