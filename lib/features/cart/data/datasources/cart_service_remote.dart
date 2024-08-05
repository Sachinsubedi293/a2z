import 'package:dio/dio.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/cart/data/models/cart_model.dart';

class CartServiceRemote {
  final Dio dio;

  CartServiceRemote(this.dio);

  Future<CartDataModel> fetchCart() async {
    try {
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response = await dio.get('http://10.0.2.2:8000/api/v1/cart/cart/',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${loginResModel!.accessToken}'
          }));

      print('Response data: ${response.data}'); // Log response data

      if (response.statusCode == 200) {
        final responseData = response.data['data']; // Extract the 'data' field
        return CartDataModel.fromJson(responseData);
      } else {
        throw Exception('Failed to load cart: ${response.statusMessage}');
      }
    } catch (e) {
      throw Exception('Failed to load cart: $e');
    }
  }

  Future<void> deleteCartItem(int itemId) async {
    try {
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response = await dio.delete('http://10.0.2.2:8000/api/v1/cart/cart/remove/$itemId/',
          options: Options(headers: {
            'Content-Type': 'application/json',
            'Authorization': 'Bearer ${loginResModel!.accessToken}'
          }));

      if (response.statusCode == 200) {
        final msg = response.data['message'];
        print('Message Cart Item Delete: $msg');
        Fluttertoast.showToast(msg: 'Item Deleted Successfully');
      } else {
        throw Exception('Failed to delete cart item: ${response.statusMessage}');
      }
    } catch (e) {
      print("Error Deleting Cart Item\n$e");
      Fluttertoast.showToast(msg: 'Failed to Delete Item');
    }
  }
}
