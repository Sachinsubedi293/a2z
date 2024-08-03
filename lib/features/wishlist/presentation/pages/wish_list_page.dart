import 'package:flutter/material.dart';

class WishlistPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
     
      body: _buildWishlistItems(),
    );
  }

  Widget _buildWishlistItems() {
    // Static data for wishlist items
    List<Map<String, String>> wishlistItems = [
      {
        'title': 'Gold Earrings',
        'price': '200.00',
        'imageUrl': 'https://example.com/gold_earrings.jpg'
      },
      {
        'title': 'Platinum Ring',
        'price': '500.00',
        'imageUrl': 'https://example.com/platinum_ring.jpg'
      },
    ];

    return ListView.builder(
      itemCount: wishlistItems.length,
      itemBuilder: (context, index) {
        return _buildWishlistItem(
          wishlistItems[index]['title']!,
          wishlistItems[index]['price']!,
          wishlistItems[index]['imageUrl']!,
        );
      },
    );
  }

  Widget _buildWishlistItem(String title, String price, String imageUrl) {
    return ListTile(
      leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(title),
      subtitle: Text('\$$price'),
      trailing: IconButton(
        icon: Icon(Icons.add_shopping_cart),
        onPressed: () {
          // Implement add to cart functionality here
        },
      ),
    );
  }
}
