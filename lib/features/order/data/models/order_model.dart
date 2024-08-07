import 'package:a2zjewelry/features/order/domain/entities/order_entity.dart';

class OrderModel extends OrderEntity {
  OrderModel({
    required int id,
    required int user,
    required int product,
    required int quantity,
    required DateTime createdAt,
    required int cart,
    required bool isCompleted,
    required StatusModel status,
  }) : super(
          id: id,
          user: user,
          product: product,
          quantity: quantity,
          createdAt: createdAt,
          cart: cart,
          isCompleted: isCompleted,
          status: status,
        );

  factory OrderModel.fromJson(Map<String, dynamic> json) {
    return OrderModel(
      id: json['id'],
      user: json['user'],
      product: json['product'],
      quantity: json['quantity'],
      createdAt: DateTime.parse(json['created_at']),
      cart: json['cart'],
      isCompleted: json['is_completed'],
      status: StatusModel.fromJson(json['status']),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'user': user,
      'product': product,
      'quantity': quantity,
      'created_at': createdAt.toIso8601String(),
      'cart': cart,
      'is_completed': isCompleted,
      'status': (status as StatusModel).toJson(),
    };
  }
}

class StatusModel extends Status {
  StatusModel({
    required int id,
    required String name,
  }) : super(
          id: id,
          name: name,
        );

  factory StatusModel.fromJson(Map<String, dynamic> json) {
    return StatusModel(
      id: json['id'],
      name: json['name'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
    };
  }
}
