import 'package:flutter/material.dart';

class CartItem extends StatelessWidget {
  final String title;
  final String price;
  final String quantity;
  final String imageUrl;
  final VoidCallback onDelete;

  CartItem({
    required this.title,
    required this.price,
    required this.quantity,
    required this.imageUrl,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListTile(
      leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(title),
      subtitle: Text('Price: \$$price\nQuantity: $quantity'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: onDelete,
      ),
    );
  }
}
