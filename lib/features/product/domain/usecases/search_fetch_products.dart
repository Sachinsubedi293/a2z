import 'package:a2zjewelry/features/product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/product/domain/repositories/product_repo.dart';

class FetchProducts {
  final ProductRepository repository;

  FetchProducts(this.repository);

  Future<List<Product>> execute(int page, int pageSize, String query) {
    return repository.fetchProducts(page, pageSize, query);
  }
}