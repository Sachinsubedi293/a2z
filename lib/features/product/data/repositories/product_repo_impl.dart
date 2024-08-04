
import 'package:a2zjewelry/features/product/data/datasources/product_fetch_id.dart';
import 'package:a2zjewelry/features/product/data/models/search_model.dart';
import 'package:a2zjewelry/features/product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/product/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService productService;

  ProductRepositoryImpl(this.productService);

  @override
  Future<List<Product>> fetchProducts(int page, int pageSize, String query) async {
    final productModels = await productService.fetchAllProducts(page, pageSize, query);
    return productModels.map((model) => _mapProductModelToEntity(model)).toList();
  }

  @override
  Future<Product> fetchProductById(int id) async {
    final productModels = await productService.fetchProductwithId(id);
    if (productModels.isEmpty) {
      throw Exception('Product not found');
    }
    return _mapProductModelToEntity(productModels.first);
  }

  Product _mapProductModelToEntity(ProductModel model) {
    return Product(
      id: model.id,
      productName: model.productName,
      slug: model.slug,
      intro: model.intro,
      description: model.description,
      price: model.price,
      stockQuantity: model.stockQuantity,
      createdAt: model.createdAt,
      updatedAt: model.updatedAt,
      category: Category(
        id: model.category.id,
        categoryName: model.category.categoryName,
        slug: 'test',
      ),
      images: model.images.map((img) => Images(
        id: img.id,
        image: img.image,
        product: img.product,
      )).toList(),
    );
  }
}
