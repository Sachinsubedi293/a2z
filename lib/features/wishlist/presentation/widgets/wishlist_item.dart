import 'package:flutter/material.dart';

class WishlistItem extends StatelessWidget {
  final String title;
  final String price;
  final String imageUrl;

  const WishlistItem({super.key, 
    required this.title,
    required this.price,
    required this.imageUrl,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(title),
      subtitle: Text('\$$price'),
      trailing: IconButton(
        icon: const Icon(Icons.add_shopping_cart),
        onPressed: () {
          // Implement add to cart functionality here
        },
      ),
    );
  }
}
