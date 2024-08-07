import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/vendor/data/datasources/vendor_product_add_service.dart';
import 'package:a2zjewelry/features/vendor/data/repositories/vendor_add_product_repo_impl.dart';
import 'package:a2zjewelry/features/vendor/domain/repositories/vendor_repo.dart';
import 'package:a2zjewelry/features/vendor/domain/usecases/vendor_update_product.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorProductUpdateState {
  final bool loading;
  final String? error;

  VendorProductUpdateState({this.loading = false, this.error});

  VendorProductUpdateState copyWith({bool? loading, String? error}) {
    return VendorProductUpdateState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}


class VendorUpdateNotifier extends StateNotifier<AsyncValue<void>> {
  final ProductRepository repository;

  VendorUpdateNotifier(this.repository) : super(const AsyncData(null));

  Future<void> updateProduct(Product product,int productId) async {
    state = const AsyncLoading();
    try {
      await repository.updateProductsofvendor(product,productId);
      state = const AsyncData(null);
      
    } catch (e,stackTrace) {
      state = AsyncError(e,stackTrace);
    }
  }
}

final vendorUpdateProvider = StateNotifierProvider<VendorUpdateNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return VendorUpdateNotifier(repository);
});

final updateProductUseCaseProvider = Provider<VendorUpdateProduct>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return VendorUpdateProduct(repository);
});

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  return ProductRepositoryImpl(remoteDataSource);
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSource(dio);
});


final dioProvider = Provider<Dio>((ref) {
  return DioClient().createDio();
});
