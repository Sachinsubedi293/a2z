class ProductModel {
  final int? id;  // Nullable id
  final String name;
  final String slug;
  final String intro;
  final String description;
  final CategoryModel category;
  final double price;
  final int stockQuantity;
  final bool listInEcommerce;
  final List<ImageItemModel> images;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    return ProductModel(
      id: json['id'],
      name: json['name'],
      slug: json['slug'],
      intro: json['intro'],
      description: json['description'],
      category: CategoryModel.fromJson(json['category']),
      price: double.parse(json['price']),
      stockQuantity: json['stock_quantity'],
      listInEcommerce: json['list_in_ecommerce'],
      images: (json['images'] as List)
          .map((image) => ImageItemModel.fromJson(image))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    final data = {
      'name': name,
      'slug': slug,
      'intro': intro,
      'description': description,
      'category': category.toJson(),
      'price': price.toString(),
      'stock_quantity': stockQuantity,
      'list_in_ecommerce': listInEcommerce,
      'images': images.map((image) => image.toJson()).toList(),
    };
    if (id != null) {
      data['id'] = id!;
    }
    return data;
  }
}

class CategoryModel {
  final String name;

  CategoryModel({required this.name});

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(name: json['name']);
  }

  Map<String, dynamic> toJson() {
    return {'name': name};
  }
}

class ImageItemModel {
  final String image;

  ImageItemModel({required this.image});

  factory ImageItemModel.fromJson(Map<String, dynamic> json) {
    return ImageItemModel(image: json['image']);
  }

  Map<String, dynamic> toJson() {
    return {'image': image};
  }
}
