import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts(int page, int pageSize, String query);
  Future<List<Product>> fetchAllProductsofvendor(
      int page, int pageSize, String query);
  Future<Product> fetchProductById(int id);
  Future<void> addToCart(int product, int quantity);
}
