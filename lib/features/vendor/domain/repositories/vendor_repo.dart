import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';

abstract class ProductRepository {
  Future<void> addProduct(Product product);
  Future<void> updateProductsofvendor(Product product, int productId);
  Future<void> deleteVendorProductItem(int productId);
}
