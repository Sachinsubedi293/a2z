import 'package:a2zjewelry/features/search_product/data/datasources/search_remote.dart';
import 'package:a2zjewelry/features/search_product/data/models/search_model.dart';
import 'package:a2zjewelry/features/search_product/domain/entities/search_product.dart';
import 'package:a2zjewelry/features/search_product/domain/repositories/product_repo.dart';

class ProductRepositoryImpl implements ProductRepository {
  final ProductService productService;

  ProductRepositoryImpl(this.productService);

  @override
  Future<List<Product>> fetchProducts(int page, int pageSize, String query) async {
    final productModels = await productService.fetchAllProducts(page, pageSize, query);
    return productModels.map((model) => _mapProductModelToEntity(model)).toList();
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
        slug: model.category.slug,
        createdAt: model.category.createdAt,
        updatedAt: model.category.updatedAt,
      ),
      images: model.images.map((img) => Image(
        id: img.id,
        image: img.image,
        product: img.product,
      )).toList(),
    );
  }
}