class CartItemDataModel {
  final int id;
  final int product;
  final int quantity;

  CartItemDataModel({
    required this.id,
    required this.product,
    required this.quantity,
  });

  factory CartItemDataModel.fromJson(Map<String, dynamic> json) {
    return CartItemDataModel(
      id: json['id'],
      product: json['product'],
      quantity: json['quantity'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'product': product,
      'quantity': quantity,
    };
  }
}
