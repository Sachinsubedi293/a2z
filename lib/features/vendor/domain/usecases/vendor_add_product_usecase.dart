import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/vendor/domain/repositories/vendor_repo.dart';

class VendorAddProductUsecase {
  final ProductRepository repository;

  VendorAddProductUsecase(this.repository);

  Future<void> execute(Product product) async {
    await repository.addProduct(product);
  }
}