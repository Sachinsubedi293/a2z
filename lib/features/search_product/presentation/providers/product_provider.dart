import 'package:a2zjewelry/features/search_product/data/datasources/search_remote.dart';
import 'package:a2zjewelry/features/search_product/data/repositories/product_repo_impl.dart';
import 'package:a2zjewelry/features/search_product/domain/repositories/product_repo.dart';
import 'package:dio/dio.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:a2zjewelry/features/search_product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/search_product/domain/usecases/search_fetch_products.dart';

class ProductNotifier extends StateNotifier<AsyncValue<List<Product>>> {
  final FetchProducts fetchProducts;
  int _currentPage = 1;
  final int _pageSize = 10;
  bool _hasMoreData = true;
  String _searchQuery = '';

  ProductNotifier(this.fetchProducts) : super(const AsyncValue.loading()) {
    _fetchProducts();
  }

Future<void> _fetchProducts() async {
  if (!_hasMoreData) return;

  try {
    print('Fetching products...');
    final products = await fetchProducts.execute(_currentPage, _pageSize, _searchQuery);
    print('Products fetched: ${products.length}');
    
    if (products.isEmpty) {
      _hasMoreData = false;
    } else {
      state = state.when(
        data: (existingProducts) => AsyncValue.data([...existingProducts, ...products]),
        loading: () => AsyncValue.data(products),
        error: (error, stackTrace) => AsyncValue.error(error, stackTrace),
      );
      _currentPage++;
    }
  } catch (e, stackTrace) {
    print('Error fetching products: $e');
    state = AsyncValue.error(e, stackTrace);
  }
}


  void loadMore() {
    if (_hasMoreData) {
      _fetchProducts();
    }
  }

  void search(String query) {
    _searchQuery = query;
    _currentPage = 1;
    _hasMoreData = true;
    _fetchProducts();
  }
}


final dioProvider = Provider((ref) {
  final dio = Dio();
  // Customize Dio instance here if needed (e.g., add interceptors)
  return dio;
});

// Service provider
final productServiceProvider = Provider((ref) {
  final dio = ref.read(dioProvider);
  return ProductService(dio);
});

// Repository provider
final productRepositoryProvider = Provider<ProductRepository>((ref) {
  final productService = ref.read(productServiceProvider);
  return ProductRepositoryImpl(productService);
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