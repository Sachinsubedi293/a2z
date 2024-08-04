class ProductModel {
  final int id;
  final String productName;
  final String slug;
  final String intro;
  final String description;
  final String price;
  final int stockQuantity;
  final DateTime createdAt;
  final DateTime updatedAt;
  final CategoryModel category;
  final List<ImageModel> images;

  ProductModel({
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

  factory ProductModel.fromJson(Map<String, dynamic> json) {
    List<ImageModel> imageList = (json['images'] as List<dynamic>?)
        ?.map((img) => ImageModel.fromJson(img))
        .toList() ?? [];

    // Set the first image to the specific URL if the list is not empty
    if (imageList.isNotEmpty) {
      imageList[0] = ImageModel(
        id: imageList[0].id,
        image: 'https://discord.com/assets/a0180771ce23344c2a95.png',
        product: imageList[0].product,
      );
    }

    return ProductModel(
      id: json['id'],
      productName: json['ProductName'],
      slug: json['slug'],
      intro: json['intro'],
      description: json['Description'],
      price: json['Price'],
      stockQuantity: json['StockQuantity'],
      createdAt: DateTime.parse(json['CreatedAt']),
      updatedAt: DateTime.parse(json['UpdatedAt']),
      category: CategoryModel.fromJson(json['CategoryID']),
      images: imageList,
    );
  }



  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'ProductName': productName,
      'slug': slug,
      'intro': intro,
      'Description': description,
      'Price': price,
      'StockQuantity': stockQuantity,
      'CreatedAt': createdAt.toIso8601String(),
      'UpdatedAt': updatedAt.toIso8601String(),
      'CategoryID': category.toJson(),
      'images': images.map((img) => img.toJson()).toList(),
    };
  }
}

class CategoryModel {
  final int id;
  final String categoryName;

  CategoryModel({
    required this.id,
    required this.categoryName,
  });

  factory CategoryModel.fromJson(Map<String, dynamic> json) {
    return CategoryModel(
      id: json['id'] ?? 0,
      categoryName: json['CategoryName'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'CategoryName': categoryName,
    };
  }
}

class ImageModel {
  final int id;
  final String image;
  final int product;

  ImageModel({
    required this.id,
    required this.image,
    required this.product,
  });

  factory ImageModel.fromJson(Map<String, dynamic> json) {
    return ImageModel(
      id: json['id'],
      image: json['image'],
      product: json['product'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'image': image,
      'product': product,
    };
  }
}
