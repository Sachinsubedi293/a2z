import 'package:a2zjewelry/features/search_product/domain/entities/search_product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts(int page, int pageSize, String query);
}