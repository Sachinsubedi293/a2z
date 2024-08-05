import 'package:a2zjewelry/features/cart/domain/repositories/cart_repo.dart';

class  CartDeleteItem{
   final CartRepository cartRepository;

   
  CartDeleteItem(this.cartRepository);

  Future<void> execute(int itemId) async {
    return await cartRepository.deletecartItem(itemId);
  }
}