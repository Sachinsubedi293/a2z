class OrderEntity {
  final int id;
  final int user;
  final int product;
  final int quantity;
  final DateTime createdAt;
  final int cart;
  final bool isCompleted;
  final Status status;

  OrderEntity({
    required this.id,
    required this.user,
    required this.product,
    required this.quantity,
    required this.createdAt,
    required this.cart,
    required this.isCompleted,
    required this.status,
  });
}

class Status {
  final int id;
  final String name;

  Status({
    required this.id,
    required this.name,
  });
}
