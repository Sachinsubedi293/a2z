import 'dart:async';
import 'package:a2zjewelry/features/product/data/datasources/cart_add_remote.dart';
import 'package:a2zjewelry/features/product/data/datasources/product_fetch_id.dart';
import 'package:a2zjewelry/features/product/data/repositories/product_repo_impl.dart';
import 'package:a2zjewelry/features/product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/product/domain/repositories/product_repo.dart';
import 'package:a2zjewelry/features/product/domain/usecases/search_fetch_products.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:dio/dio.dart';

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final FetchProducts fetchProducts;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMoreData = true;
  String _searchQuery = '';
  Timer? _debounceTimer;
  Timer? _fetchTimer;

  ProductNotifier(this.fetchProducts) : super(const AsyncValue.loading()) {
    _fetchProducts(); // Initial fetch
    _startPeriodicFetching(); // Start periodic fetching
  }

  Future<void> _fetchProducts({bool isPagination = false}) async {
    // Only handle pagination fetch if there is more data to fetch
    if (!_hasMoreData && isPagination) return;

    try {
      print('Fetching products: page $_currentPage, query $_searchQuery');

      final products = await fetchProducts.execute(_currentPage, _pageSize, _searchQuery);

      if (products.isEmpty) {
        _hasMoreData = false;
      }


      final existingProductIds = state.when(
        data: (existingProducts) => existingProducts.map((product) => product.id).toSet(),
        loading: () => <int>{},
        error: (error, stackTrace) => <int>{},
      );


      final newProducts = products.where((product) => !existingProductIds.contains(product.id)).toList();

      if (isPagination) {
        state = state.when(
          data: (existingProducts) => AsyncValue.data([...existingProducts, ...newProducts]),
          loading: () => AsyncValue.data(newProducts),
          error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
        );
      } else {
        state = AsyncValue.data([...existingProductIds.map((id) => products.firstWhere((product) => product.id == id)), ...newProducts]);
      }

      // Update pagination state
      if (newProducts.isNotEmpty && isPagination) {
        _currentPage++;
      } else {
        _hasMoreData = false;
      }

    } catch (e, stackTrace) {
      print('Error fetching products: $e');
      state = AsyncValue.error(e, stackTrace);
    }
  }

  void _startPeriodicFetching() {
    _fetchTimer = Timer.periodic(const Duration(seconds: 5), (timer) {
      // Always fetch data every 5 seconds
      _fetchProducts();
    });
  }

  void stopPeriodicFetching() {
    _fetchTimer?.cancel();
  }

  @override
  void dispose() {
    _fetchTimer?.cancel();
    super.dispose();
  }

  void loadMore() {
    if (_hasMoreData) {
      _fetchProducts(isPagination: true);
    }
  }

  void search(String query) {
    if (_debounceTimer?.isActive ?? false) _debounceTimer?.cancel();

    _debounceTimer = Timer(const Duration(milliseconds: 300), () {
      _searchQuery = query;
      _currentPage = 1;
      _hasMoreData = true;
      _fetchProducts();
    });
  }

  Future<void> refresh() async {
    _currentPage = 1;
    _hasMoreData = true;
    await _fetchProducts();
  }
}

final dioProvider = Provider((ref) {
  final dio = Dio();
  return dio;
});

// Service provider
final productServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return ProductService(dio);
});

final cartServiceprovider=Provider((ref){
final dio=ref.read(dioProvider);
return ProductCartService(dio);
});

// Repository provider
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final productService = ref.read(productServiceProvider);
  final cartservice=ref.read(cartServiceprovider);
  return ProductRepositoryImpl(productService,cartservice);
});

// Use case provider
final fetchProductsProvider = Provider((ref) {
  final productRepository = ref.read(productRepositoryProvider);
  return FetchProducts(productRepository);
});

// Notifier provider
final productNotifierProvider = StateNotifierProvider<ProductNotifier, AsyncValue<List<Product>>>((ref) {
  final fetchProducts = ref.read(fetchProductsProvider);
  return ProductNotifier(fetchProducts);
});
