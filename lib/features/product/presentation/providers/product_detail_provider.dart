import 'package:a2zjewelry/features/product/data/datasources/product_fetch_id.dart';
import 'package:a2zjewelry/features/product/data/repositories/product_repo_impl.dart';
import 'package:a2zjewelry/features/product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/product/domain/repositories/product_repo.dart';
import 'package:a2zjewelry/features/product/domain/usecases/fetch_product_by_id.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';

class ProductDetailNotifier extends StateNotifier<AsyncValue<Product>> {
  final FetchProductById fetchProductById;

  ProductDetailNotifier(this.fetchProductById) : super(const AsyncValue.loading());

  Future<void> getProduct(int id) async {
    try {
      final product = await fetchProductById.execute(id);
      state = AsyncValue.data(product);
    } catch (e, stackTrace) {
      state = AsyncValue.error(e, stackTrace);
    }
  }
}

final dioProvider = Provider((ref) {
  final dio = Dio();
  return dio;
});

final productServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return ProductService(dio);
});

final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final productService = ref.read(productServiceProvider);
  return ProductRepositoryImpl(productService);
});

final fetchProductByIdProvider = Provider((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return FetchProductById(productRepository);
});

final productDetailNotifierProvider = StateNotifierProvider.family<ProductDetailNotifier, AsyncValue<Product>, int>((ref, id) {
  final fetchProductById = ref.read(fetchProductByIdProvider);
  final notifier = ProductDetailNotifier(fetchProductById);
  notifier.getProduct(id);
  return notifier;
});