class Cart {
  final int id;
  final int userId;
  final List<CartItem> items;
  final DateTime createdAt;
  final DateTime updatedAt;
  final double totalPrice;

  Cart({
    required this.id,
    required this.userId,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrice,
  });
}

class CartItem {
  final int id;
  final int product;
  final int quantity;

  CartItem({
    required this.id,
    required this.product,
    required this.quantity,
  });
}
