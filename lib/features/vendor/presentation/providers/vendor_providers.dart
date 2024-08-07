import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/vendor/data/datasources/vendor_product_add_service.dart';
import 'package:a2zjewelry/features/vendor/data/repositories/vendor_add_product_repo_impl.dart';
import 'package:a2zjewelry/features/vendor/domain/repositories/vendor_repo.dart';
import 'package:a2zjewelry/features/vendor/domain/usecases/vendor_add_product_usecase.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class VendorAddProductState {
  final bool loading;
  final String? error;

  VendorAddProductState({this.loading = false, this.error});

  VendorAddProductState copyWith({bool? loading, String? error}) {
    return VendorAddProductState(
      loading: loading ?? this.loading,
      error: error ?? this.error,
    );
  }
}


class VendorAddProductNotifier extends StateNotifier<AsyncValue<void>> {
  final ProductRepository repository;

  VendorAddProductNotifier(this.repository) : super(const AsyncData(null));

  Future<void> addProduct(Product product) async {
    state = const AsyncLoading();
    try {
      await repository.addProduct(product);
      state = const AsyncData(null);
    } catch (e,stackTrace) {
      state = AsyncError(e,stackTrace);
    }
  }
}

final vendorAddProductProvider = StateNotifierProvider<VendorAddProductNotifier, AsyncValue<void>>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return VendorAddProductNotifier(repository);
});

final addProductUseCaseProvider = Provider<VendorAddProductUsecase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return VendorAddProductUsecase(repository);
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
