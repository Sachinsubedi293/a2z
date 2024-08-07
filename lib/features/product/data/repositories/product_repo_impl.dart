import 'package:a2zjewelry/features/product/data/datasources/cart_add_remote.dart';
import 'package:a2zjewelry/features/product/data/datasources/product_fetch_id.dart';
import 'package:a2zjewelry/features/product/data/models/product_model.dart';
import 'package:a2zjewelry/features/product/domain/entities/product_entity.dart';
import 'package:a2zjewelry/features/product/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService productService;
  final ProductCartService cartService;

  ProductRepositoryImpl(this.productService, this.cartService);

  @override
  Future<List<Product>> fetchProducts(int page, int pageSize, String query) async {
    try {
      final productModels = await productService.fetchAllProducts(page, pageSize, query);
      return productModels.map((model) => _mapProductModelToEntity(model)).toList();
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<List<Product>> fetchAllProductsofvendor(int page, int pageSize, String query) async {
    try {
      final productModels = await productService.fetchAllProductsofavendor(page, pageSize, query);
      return productModels.map((model) => _mapProductModelToEntity(model)).toList();
    } catch (e) {
      throw Exception('Error fetching products: $e');
    }
  }

  @override
  Future<Product> fetchProductById(int id) async {
    try {
      final productModels = await productService.fetchProductwithId(id);
      if (productModels.isEmpty) {
        throw Exception('Product not found');
      }
      return _mapProductModelToEntity(productModels.first);
    } catch (e) {
      throw Exception('Error fetching product by ID: $e');
    }
  }

  Product _mapProductModelToEntity(ProductModel model) {
    return Product(
      id: model.id,
      name: model.name,
      slug: model.slug,
      intro: model.intro,
      description: model.description,
      price: model.price,
      stockQuantity: model.stockQuantity,
      category: Category(
        name: model.category.name,
      ),
      listInEcommerce: model.listInEcommerce,
      images: model.images.map((img) => ProductImage(
        image: img.image,
      )).toList(),
    );
  }

  @override
  Future<void> addToCart(int productId, int quantity) async {
    try {
      await cartService.addToCart(productId, quantity);
    } catch (e) {
      throw Exception('Error adding to cart: $e');
    }
  }
}
