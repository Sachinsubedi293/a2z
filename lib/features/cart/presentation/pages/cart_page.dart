import 'package:a2zjewelry/features/cart/presentation/widgets/cart_item.dart.dart';
import 'package:flutter/material.dart';
import '../widgets/total_price.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCartItems(),
      bottomNavigationBar: TotalPrice(totalPrice: _calculateTotalPrice()),
    );
  }

  Widget _buildCartItems() {
    // Static data for cart items
    List<Map<String, String>> cartItems = [
      {
        'title': 'Gold Necklace',
        'price': '120.00',
        'quantity': '1',
        'imageUrl': 'https://example.com/gold_necklace.jpg'
      },
      {
        'title': 'Diamond Ring',
        'price': '450.00',
        'quantity': '1',
        'imageUrl': 'https://example.com/diamond_ring.jpg'
      },
      {
        'title': 'Silver Bracelet',
        'price': '80.00',
        'quantity': '2',
        'imageUrl': 'https://example.com/silver_bracelet.jpg'
      },
    ];

    return ListView.builder(
      itemCount: cartItems.length,
      itemBuilder: (context, index) {
        return CartItem(
          title: cartItems[index]['title']!,
          price: cartItems[index]['price']!,
          quantity: cartItems[index]['quantity']!,
          imageUrl: cartItems[index]['imageUrl']!,
          onDelete: () {
            // Implement remove item functionality here
          },
        );
      },
    );
  }

  double _calculateTotalPrice() {
    return 120.00 + 450.00 + 80.00 * 2; // Example total price calculation
  }
}
