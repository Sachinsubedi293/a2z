class Product {
  final int id;
  final String productName;
  final String slug;
  final String intro;
  final String description;
  final String price;
  final int stockQuantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final Category category;
final List<Images> images;

  Product({
    required this.id,
    required this.productName,
    required this.slug,
    required this.intro,
    required this.description,
    required this.price,
    required this.stockQuantity,
    required this.createdAt,
    required this.updatedAt,
    required this.category,
   required this.images,
  });
}

class Category {
  final int id;
  final String categoryName;
  final String slug;


  Category({
    required this.id,
    required this.categoryName,
    required this.slug,

  });
}

class Images {
  final int id;
  final String image;
  final int product;

  Images({
    required this.id,
    required this.image,
    required this.product,
  });
}
