import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/vendor/domain/repositories/vendor_repo.dart';

class VendorUpdateProduct {
   final ProductRepository repository;

  VendorUpdateProduct(this.repository);

  Future<void> execute(Product product,int productId) async {
    await repository.updateProductsofvendor(product,productId);
  }
}