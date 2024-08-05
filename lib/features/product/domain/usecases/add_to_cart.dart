import 'package:a2zjewelry/features/product/domain/repositories/product_repo.dart';

class AddToCart {
  final ProductRepository repository;

  AddToCart(this.repository);

  Future<void> execute(int productId,int quantity) {
    return repository.addToCart(productId,quantity);
  }
}