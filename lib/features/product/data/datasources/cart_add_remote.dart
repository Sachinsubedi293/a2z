import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProductCartService {
  final Dio _dio;

  ProductCartService(this._dio);
  Future<void> addToCart(int productId, int quantity) async {
    try {
      print("ProductId:$productId");
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response =
          await _dio.post('http://10.0.2.2:8000/api/v1/cart/cart/add/',
              data: {'product_id': productId, 'quantity': quantity},
              options: Options(headers: {
                'Content-Type': 'application/json',
                'Authorization': 'Bearer ${loginResModel!.accessToken}'
              }));

      if (response.statusCode == 200) {
        print('Product added to cart successfully');
        Fluttertoast.showToast(msg: "Product added to cart successfully");
      } else {
        Fluttertoast.showToast(msg: "Failed to add product to cart.");

        print('Failed to add product to cart: ${response.statusMessage}');
      }
    } catch (e) {
      print('Error adding product to cart: $e');
    }
  }
}
