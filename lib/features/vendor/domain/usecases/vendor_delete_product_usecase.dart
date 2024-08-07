import 'package:a2zjewelry/features/vendor/domain/repositories/vendor_repo.dart';

class VendorDeleteProductUsecase {
   final ProductRepository repository;

  VendorDeleteProductUsecase(this.repository);

  Future<void> execute(int productId) async {
    await repository.deleteVendorProductItem(productId);
  }
}