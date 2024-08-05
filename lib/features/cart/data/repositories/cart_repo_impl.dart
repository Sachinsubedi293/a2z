import 'package:a2zjewelry/features/cart/data/datasources/cart_service_remote.dart';
import 'package:a2zjewelry/features/cart/data/models/cart_model.dart';
import 'package:a2zjewelry/features/cart/domain/entities/cart_entity.dart';
import 'package:a2zjewelry/features/cart/domain/repositories/cart_repo.dart';

class CartRepositoryImpl implements CartRepository {
  final CartServiceRemote cartServiceRemote;

  CartRepositoryImpl(this.cartServiceRemote);

  @override
  Future<void> deletecartItem(int itemId) async {
    try {
      await cartServiceRemote.deleteCartItem(itemId);
    } catch (e) {
      throw Exception('Failed to delete cart item: $e');
    }
  }

  @override
  Future<Cart> fetchCart() async {
    try {
      final cartDataModel = await cartServiceRemote.fetchCart();
      return _mapToEntity(cartDataModel);
    } catch (e) {
      throw Exception('Failed to fetch cart: $e');
    }
  }

  Cart _mapToEntity(CartDataModel dataModel) {
    return Cart(
      id: dataModel.id,
      userId: dataModel.user,
      items: dataModel.items.map((item) => CartItem(
        id: item.id,
        product: item.product,
        quantity: item.quantity,
      )).toList(),
      createdAt: DateTime.parse(dataModel.createdAt),
      updatedAt: DateTime.parse(dataModel.updatedAt),
      totalPrice: dataModel.totalPrice,
    );
  }
}
