import 'package:a2zjewelry/features/cart/domain/entities/cart_entity.dart';

abstract class CartRepository {
  Future<Cart> fetchCart();
  Future<void>deletecartItem(int itemId);
}
