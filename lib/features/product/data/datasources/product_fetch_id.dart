import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/product/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductService {
  final Dio _dio;

  ProductService(this._dio);

  Future<List<ProductModel>> fetchAllProducts(
      int page, int pageSize, String query) async {
    try {
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response =
          await _dio.get('http://10.0.2.2:8000/api/v1/products/list',
              queryParameters: {
                'page': page,
                'page_size': pageSize,
              },
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${loginResModel!.accessToken}',
                },
              ));

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
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response =
          await _dio.get('http://10.0.2.2:8000/api/v1/products/$id/',
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${loginResModel!.accessToken}',
                },
              ));

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

  Future<List<ProductModel>> fetchAllProductsofavendor(
      int page, int pageSize, String query) async {
    try {
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response =
          await _dio.get('http://10.0.2.2:8000/api/v1/products/user/products/',
              // queryParameters: {
              //   'page': page,
              //   'page_size': pageSize,
              // },
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${loginResModel!.accessToken}',
                },
              ));
      print(response.data);
      final data = response.data as Map<String, dynamic>;
      final products = (data['data'] as List)
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
}
