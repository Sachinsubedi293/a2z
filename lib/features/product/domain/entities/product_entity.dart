class Product {
  final int? id;  // Nullable id
  final String name;
  final String slug;
  final String intro;
  final String description;
  final Category category;
  final double price;
  final int stockQuantity;
  final bool listInEcommerce;
  final List<ProductImage> images;

  Product({
    this.id,  // id is nullable
    required this.name,
    required this.slug,
    required this.intro,
    required this.description,
    required this.category,
    required this.price,
    required this.stockQuantity,
    required this.listInEcommerce,
    required this.images,
  });
}

class Category {
  final String name;

  Category({
    required this.name,
  });
}

class ProductImage {
  final String image;

  ProductImage({
    required this.image,
  });
}
