import 'package:a2zjewelry/features/product/domain/entities/search_product.dart';

abstract class ProductRepository {
  Future<List<Product>> fetchProducts(int page, int pageSize, String query);
  Future<Product> fetchProductById(int id);
  Future<void> addToCart(int product,int quantity);
}