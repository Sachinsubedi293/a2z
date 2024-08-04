import 'package:flutter/material.dart';
import 'wishlist_item.dart';

class WishlistItems extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
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
        return WishlistItem(
          title: wishlistItems[index]['title']!,
          price: wishlistItems[index]['price']!,
          imageUrl: wishlistItems[index]['imageUrl']!,
        );
      },
    );
  }
}
