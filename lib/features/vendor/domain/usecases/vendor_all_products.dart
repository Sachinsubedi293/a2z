import 'package:a2zjewelry/features/product/data/repositories/product_repo_impl.dart';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';

class FetchAllProductsofavendor {
  final ProductRepositoryImpl repository;

  FetchAllProductsofavendor(this.repository);

  Future<List<Product>> execute(int page, int pageSize, String query) {
    return repository.fetchAllProductsofvendor(page,pageSize,query);
  }
}