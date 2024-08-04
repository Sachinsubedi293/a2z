// widgets/product_item.dart
import 'package:flutter/material.dart';

class ProductItem extends StatelessWidget {
  final String title;
  final double price;
  final String imageUrl;

  const ProductItem({required this.title, required this.price, required this.imageUrl});

  @override
  Widget build(BuildContext context) {
    return Container(
      width: 150,
      margin: EdgeInsets.only(right: 16),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Container(
            height: 150,
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(8),
              image: DecorationImage(
                image: NetworkImage(imageUrl),
                fit: BoxFit.cover,
              ),
            ),
          ),
          SizedBox(height: 8),
          Text(title),
          Text('\$$price'),
        ],
      ),
    );
  }
}
