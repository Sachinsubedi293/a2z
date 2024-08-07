import 'package:a2zjewelry/core/temp/model.dart';
import 'package:flutter/material.dart';

class OrderListPage extends StatelessWidget {
  final List<Order> orders = [
    Order(
      id: 0,
      user: 0,
      product: 0,
      quantity: 2147483647,
      createdAt: DateTime.parse("2024-08-07T09:50:28.596Z"),
      cart: 0,
      isCompleted: true,
      status: OrderStatus(id: 0, name: "string"),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Orders List'),
      ),
      body: ListView.builder(
        itemCount: orders.length,
        itemBuilder: (context, index) {
          final order = orders[index];
          return Card(
            margin: const EdgeInsets.all(8.0),
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text('Order ID: ${order.id}', style: const TextStyle(fontWeight: FontWeight.bold)),
                  const SizedBox(height: 8),
                  Text('User ID: ${order.user}'),
                  const SizedBox(height: 8),
                  Text('Product ID: ${order.product}'),
                  const SizedBox(height: 8),
                  Text('Quantity: ${order.quantity}'),
                  const SizedBox(height: 8),
                  Text('Created At: ${order.createdAt.toLocal()}'),
                  const SizedBox(height: 8),
                  Text('Cart ID: ${order.cart}'),
                  const SizedBox(height: 8),
                  Text('Is Completed: ${order.isCompleted}'),
                  const SizedBox(height: 8),
                  Text('Status: ${order.status.name}'),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
