import 'package:a2zjewelry/features/cart/domain/repositories/cart_repo.dart';
import 'package:a2zjewelry/features/cart/domain/entities/cart_entity.dart';

class FetchCartUseCase {
  final CartRepository cartRepository;

  FetchCartUseCase(this.cartRepository);

  Future<Cart> execute() async {
    return await cartRepository.fetchCart();
  }
}
