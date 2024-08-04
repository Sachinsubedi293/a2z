import 'package:a2zjewelry/features/search_product/data/models/search_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';

class ProductService {
  final Dio _dio;

  ProductService(this._dio) {
    _dio.interceptors.add(
      InterceptorsWrapper(
        onRequest: (options, handler) async {
          final box = Hive.box<LoginResModel>('loginBox');
          final token = box.get('tokens')?.accessToken;

          if (token != null) {
            options.headers['Authorization'] = 'Bearer $token';
          }
          return handler.next(options);
        },
      ),
    );
  }

  Future<List<ProductModel>> fetchAllProducts(int page, int pageSize, String query) async {
    try {
      final response = await _dio.get(
        'api/v1/products/list', 
        queryParameters: {
          'page': page,
          'page_size': pageSize,
        },
      );
      
      final data = response.data as Map<String, dynamic>;
      final products = (data['results'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      if (products.isEmpty) {
        Fluttertoast.showToast(
          msg: "No products found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,);
        return [];
      } 

      return products;
    } on DioException catch (e) {
      Fluttertoast.showToast(
        msg: "Failed to fetch products: ${e.message}",
        toastLength: Toast.LENGTH_LONG,
        gravity: ToastGravity.BOTTOM,
        timeInSecForIosWeb: 1,
        backgroundColor: Colors.red,
        textColor: Colors.white,
        fontSize: 16.0,
      );
      rethrow;
    }
  }
}
