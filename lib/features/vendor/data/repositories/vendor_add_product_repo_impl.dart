import 'package:a2zjewelry/features/product/data/models/product_model.dart';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/vendor/data/datasources/vendor_product_add_service.dart';
import 'package:a2zjewelry/features/vendor/domain/repositories/vendor_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductRemoteDataSource remoteDataSource;

  ProductRepositoryImpl(this.remoteDataSource);

  @override
  Future<void> addProduct(Product product) async {
    try {
      await remoteDataSource.addProduct(ProductModel(
        name: product.name,
        slug: product.slug,
        intro: product.intro,
        description: product.description,
        category: CategoryModel(name: product.category.name),
        price: product.price,
        stockQuantity: product.stockQuantity,
        listInEcommerce: product.listInEcommerce,
        images: product.images.map((img) => ImageItemModel(image: img.image)).toList(),
      ));
    } catch (e) {
      throw Exception('Failed to add product: $e');
    }
  }

  @override
  Future<void> updateProductsofvendor(Product product, int productId) async {
    try {
      await remoteDataSource.updateProductsofvendor(ProductModel(
        name: product.name,
        slug: product.slug,
        intro: product.intro,
        description: product.description,
        category: CategoryModel(name: product.category.name),
        price: product.price, 
        stockQuantity: product.stockQuantity,
        listInEcommerce: product.listInEcommerce,
        images: product.images.map((img) => ImageItemModel(image: img.image)).toList(),
      ), productId);
    } catch (e) {
      throw Exception('Failed to update product: $e');
    }
  }

  @override
  Future<void> deleteVendorProductItem(int productId) async {
    await remoteDataSource.deleteVendorProductItem(productId);
  }
}
