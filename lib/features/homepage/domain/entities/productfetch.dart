import 'package:dio/dio.dart';

class ApiService {
  final Dio _dio = Dio();

  // Base URL for API calls
  final String _baseUrl = 'https://retoolapi.dev/2esyW0';

  Future<List<Product>> fetchProducts() async {
    final response = await _dio.get('$_baseUrl/data');
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load products');
    }
  }

  Future<List<Product>> fetchNewArrivals() async {
    final response = await _dio.get('$_baseUrl/data');
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load new arrivals');
    }
  }

  Future<List<Product>> fetchBestSellers() async {
    final response = await _dio.get('$_baseUrl/data');
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load best sellers');
    }
  }

  Future<List<Product>> fetchSeasonalPromotions() async {
    final response = await _dio.get('$_baseUrl/data');
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => Product.fromJson(json)).toList();
    } else {
      throw Exception('Failed to load seasonal promotions');
    }
  }

  Future<List<String>> fetchCustomerReviews() async {
    final response = await _dio.get('$_baseUrl/data');
    if (response.statusCode == 200) {
      final data = response.data as List<dynamic>;
      return data.map((json) => json['review'] as String).toList();
    } else {
      throw Exception('Failed to load customer reviews');
    }
  }
}

class Product {
  final String name;
  final int price;
  final String image;

  Product({
    required this.name,
    required this.price,
    required this.image,
  });

  factory Product.fromJson(Map<String, dynamic> json) {
    return Product(
      name: json['name'],
      price: json['price'],
      image:  'https://w7.pngwing.com/pngs/344/344/png-transparent-google-logo-google-logo-g-suite-google-text-logo-symbol-thumbnail.png',
    );
  }
}
