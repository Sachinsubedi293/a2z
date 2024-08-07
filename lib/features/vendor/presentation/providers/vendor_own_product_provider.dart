import 'dart:async';
import 'package:a2zjewelry/core/network/dio_clent.dart';
import 'package:a2zjewelry/features/product/data/datasources/cart_add_remote.dart';
import 'package:a2zjewelry/features/product/data/datasources/product_fetch_id.dart';
import 'package:a2zjewelry/features/product/data/repositories/product_repo_impl.dart';
import 'package:a2zjewelry/features/vendor/domain/usecases/vendor_all_products.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';

class ProductState {
  final AsyncValue<List<Product>> products;
  final String query;

  ProductState({
    required this.products,
    this.query = '',
  });

  ProductState copyWith({
    AsyncValue<List<Product>>? products,
    String? query,
  }) {
    return ProductState(
      products: products ?? this.products,
      query: query ?? this.query,
    );
  }
}

class ProductNotifier extends StateNotifier<ProductState> {
  final FetchAllProductsofavendor fetchProducts;
  int _currentPage = 1;
  final int _pageSize = 10;

  String _searchQuery = '';
  Timer? _debounceTimer;

  ProductNotifier(this.fetchProducts) : super(ProductState(products: const AsyncValue.loading())) {
    _fetchProducts();
  }

  Future<void> _fetchProducts({bool isPagination = false}) async {
    final existingProducts = state.products.maybeWhen(
      data: (data) => data,
      orElse: () => [],
    );

    try {
      final products = await fetchProducts.execute(_currentPage, _pageSize, _searchQuery);

      final existingProductIds = existingProducts.map((product) => product.id).toSet();
      final newProducts = products.where((product) => !existingProductIds.contains(product.id)).toList();

      if (isPagination) {
        state = state.copyWith(
          products: AsyncValue.data([
            ...existingProducts,
            ...newProducts,
          ]),
        );
        if (newProducts.isNotEmpty) {
          _currentPage++;
        }
      } else {
        state = state.copyWith(
          products: AsyncValue.data(products),
        );
      }
    } catch (e, stackTrace) {
      state = state.copyWith(products: AsyncValue.error(e, stackTrace));
    }
  }

  void loadMore() {
    _fetchProducts(isPagination: true);
  }

  void search(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _searchQuery = query;
      _currentPage = 1;
      _fetchProducts();
    });
  }

  Future<void> refresh() async {
    _currentPage = 1;
    await _fetchProducts();
  }
}

final dioProvider = Provider<Dio>((ref) {
  return DioClient().createDio();
});

final cartServiceProvider = Provider<ProductCartService>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductCartService(dio);
});

final productRemoteDataSourceProvider = Provider<ProductService>((ref) {
  final dio = ref.watch(dioProvider);
  return ProductService(dio);
});

final productRepositoryProvider = Provider<ProductRepositoryImpl>((ref) {
  final remoteDataSource = ref.watch(productRemoteDataSourceProvider);
  final cartService = ref.watch(cartServiceProvider);
  return ProductRepositoryImpl(remoteDataSource, cartService);
});

final fetchProductsProvider = Provider<FetchAllProductsofavendor>((ref) {
  final repository = ref.watch(productRepositoryProvider);
  return FetchAllProductsofavendor(repository);
});

final productNotifierProvider = StateNotifierProvider<ProductNotifier, ProductState>((ref) {
  final fetchProducts = ref.watch(fetchProductsProvider);
  return ProductNotifier(fetchProducts);
});

