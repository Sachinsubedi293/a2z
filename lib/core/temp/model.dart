class Order {
  final int id;
  final int user;
  final int product;
  final int quantity;
  final DateTime createdAt;
  final int cart;
  final bool isCompleted;
  final OrderStatus status;

  Order({
    required this.id,
    required this.user,
    required this.product,
    required this.quantity,
    required this.createdAt,
    required this.cart,
    required this.isCompleted,
    required this.status,
  });

  factory Order.fromJson(Map<String, dynamic> json) {
    return Order(
      id: json['id'],
      user: json['user'],
      product: json['product'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      cart: json['cart'],
      isCompleted: json['is_completed'],
      status: OrderStatus.fromJson(json['status']),
    );
  }
}

class OrderStatus {
  final int id;
  final String name;

  OrderStatus({
    required this.id,
    required this.name,
  });

  factory OrderStatus.fromJson(Map<String, dynamic> json) {
    return OrderStatus(
      id: json['id'],
      name: json['name'],
    );
  }
}
