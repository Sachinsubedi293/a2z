import 'package:a2zjewelry/features/vendor/data/datasources/vendor_product_add_service.dart';
import 'package:a2zjewelry/features/vendor/data/repositories/vendor_add_product_repo_impl.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/vendor/domain/usecases/vendor_delete_product_usecase.dart';
import 'package:dio/dio.dart';

class DeleteState {
  final AsyncValue<void> status;
  final bool isDeleting;
  final String? error;

  DeleteState({
    required this.status,
    this.isDeleting = false,
    this.error,
  });

  DeleteState copyWith({
    AsyncValue<void>? status,
    bool? isDeleting,
    String? error,
  }) {
    return DeleteState(
      status: status ?? this.status,
      isDeleting: isDeleting ?? this.isDeleting,
      error: error,
    );
  }
}

class DeleteNotifier extends StateNotifier<DeleteState> {
  final VendorDeleteProductUsecase deleteProductUsecase;

  DeleteNotifier(this.deleteProductUsecase)
      : super(DeleteState(status: const AsyncValue.data(null)));

  Future<void> deleteProduct(int productId) async {
    state = state.copyWith(isDeleting: true, status: const AsyncValue.loading(), error: null);
    try {
      await deleteProductUsecase.execute(productId);
      state = state.copyWith(isDeleting: false, status: const AsyncValue.data(null));
    } catch (e, stackTrace) {
      state = state.copyWith(
        isDeleting: false,
        status: AsyncValue.error(e, stackTrace),
        error: e.toString(),
      );
    }
  }
}

final dioProvider = Provider<Dio>((ref) {
  return DioClient().createDio();
});

final productRemoteDataSourceProvider = Provider<ProductRemoteDataSource>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductRemoteDataSource(dio);
});



final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);

  return ProductRepositoryImpl(remoteDataSource);
});

final vendorDeleteProductUsecaseProvider = Provider<VendorDeleteProductUsecase>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return VendorDeleteProductUsecase(repository);
});

final deleteNotifierProvider = StateNotifierProvider<DeleteNotifier, DeleteState>((ref) {
  final deleteProductUsecase = ref.watch(vendorDeleteProductUsecaseProvider);
  return DeleteNotifier(deleteProductUsecase);
});
