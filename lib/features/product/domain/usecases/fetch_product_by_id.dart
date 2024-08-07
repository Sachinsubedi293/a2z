import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/product/domain/repositories/product_repo.dart';

class FetchProductById {
  final ProductRepository repository;

  FetchProductById(this.repository);

  Future<Product> execute(int id) {
    return repository.fetchProductById(id);
  }
}