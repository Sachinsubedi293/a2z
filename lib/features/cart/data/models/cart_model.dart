import 'package:a2zjewelry/features/cart/data/models/cart_item_data_model.dart';

class CartDataModel {
  final int id;
  final int user;
  final List<CartItemDataModel> items;
  final String createdAt;
  final String updatedAt;
  final double totalPrice;

  CartDataModel({
    required this.id,
    required this.user,
    required this.items,
    required this.createdAt,
    required this.updatedAt,
    required this.totalPrice,
  });

  factory CartDataModel.fromJson(Map<String, dynamic> json) {
    return CartDataModel(
      id: json['id'],
      user: json['user'],
      items: (json['items'] as List)
          .map((item) => CartItemDataModel.fromJson(item))
          .toList(),
      createdAt: json['created_at'],
      updatedAt: json['updated_at'],
      totalPrice: (json['total_price'] as num).toDouble(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'items': items.map((item) => item.toJson()).toList(),
      'created_at': createdAt,
      'updated_at': updatedAt,
      'total_price': totalPrice,
    };
  }
}
