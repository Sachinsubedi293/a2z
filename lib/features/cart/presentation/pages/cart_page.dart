import 'package:flutter/material.dart';

class CartPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: _buildCartItems(),
      bottomNavigationBar: _buildTotalPrice(),
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
        return _buildCartItem(
          cartItems[index]['title']!,
          cartItems[index]['price']!,
          cartItems[index]['quantity']!,
          cartItems[index]['imageUrl']!,
        );
      },
    );
  }

  Widget _buildCartItem(String title, String price, String quantity, String imageUrl) {
    return ListTile(
      leading: Image.network(imageUrl, width: 50, height: 50, fit: BoxFit.cover),
      title: Text(title),
      subtitle: Text('Price: \$$price\nQuantity: $quantity'),
      trailing: IconButton(
        icon: Icon(Icons.delete),
        onPressed: () {
          // Implement remove item functionality here
        },
      ),
    );
  }

  Widget _buildTotalPrice() {
    double totalPrice = 120.00 + 450.00 + 80.00 * 2; // Example total price calculation

    return Container(
      padding: EdgeInsets.all(16),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Text(
            'Total Price:',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
          Text(
            '\$$totalPrice',
            style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
          ),
        ],
      ),
    );
  }
}
