import 'package:a2zjewelry/features/product/data/models/search_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ProductService {
  final Dio _dio;

  ProductService(this._dio);

  Future<List<ProductModel>> fetchAllProducts(
      int page, int pageSize, String query) async {
    try {
      final response = await _dio.get(
        'https://bikramsubedi.com.np/api/v1/products/list',
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
          timeInSecForIosWeb: 1,
        );
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
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: ${e.toString()}",
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

  Future<List<ProductModel>> fetchProductwithId(int id) async {
    try {
      final response = await _dio.get(
        'https://bikramsubedi.com.np/api/v1/products/$id/',
      );

      final data = response.data as Map<String, dynamic>;
      final products = (data['data'] as List)
          .map((json) => ProductModel.fromJson(json))
          .toList();

      if (products.isEmpty) {
        Fluttertoast.showToast(
          msg: "No data found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
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
    } catch (e) {
      Fluttertoast.showToast(
        msg: "An unexpected error occurred: ${e.toString()}",
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
