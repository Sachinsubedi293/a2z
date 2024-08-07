import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/product/data/models/product_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class ProductRemoteDataSource {
  final Dio dio;

  ProductRemoteDataSource(this.dio);

  Future<void> addProduct(ProductModel product) async {
    try {
      final box = await Hive.box<LoginResModel>('loginBox');
      final login = box.get('tokens');

      if (login == null || login.accessToken == null) {
        throw Exception('User token is not available or accessToken is null');
      }

      final decodedToken = JwtDecoder.decode(login.accessToken!);
      final userId = decodedToken['user_id'];

      if (userId == null) {
        throw Exception('User ID could not be extracted from the token');
      }

      // Prepare the images as MultipartFile
      final imageFiles =
          await Future.wait(product.images.map((imageItem) async {
        return MultipartFile.fromFile(imageItem.image,
            filename: imageItem.image.split('/').last);
      }).toList());

      final formData = FormData.fromMap({
        'name': product.name,
        'intro': product.intro,
        'description': product.description,
        'category': product.category.toJson(),
        'price': product.price,
        'stock_quantity': product.stockQuantity,
        'list_in_ecommerce': product.listInEcommerce,
        'user_id': userId,
        // Add the images
        'images': imageFiles,
      });

      final response = await dio.post(
        'http://10.0.2.2:8000/api/v1/products/create-product/',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${login.accessToken}',
            'Content-Type': 'multipart/form-data',
          },
        ),
      );

      if (response.statusCode != 201) {
        throw Exception('Failed to add product: ${response.statusMessage}');
      } else {
        print(response.data);
      }
    } on DioException catch (dioError) {
      print(dioError);
      throw Exception('Failed to add product: ${dioError.message}');
    } catch (e) {
      print(e);
      throw Exception('An unexpected error occurred: $e');
    }
  }

  Future<void> updateProductsofvendor(
      ProductModel product, int productId) async {
    try {
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response =
          await dio.patch('http://10.0.2.2:8000/api/v1/products/${productId}/',
              data: product.toJson(),
              options: Options(
                headers: {
                  'Authorization': 'Bearer ${loginResModel!.accessToken}',
                },
              ));

      if (response.statusCode == 404) {
        Fluttertoast.showToast(
          msg: "No products found",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else if (response.statusCode == 200) {
        Fluttertoast.showToast(
          msg: "Product Updated Successfully",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      } else {
        Fluttertoast.showToast(
          msg: "Failed to update products: ${response.statusMessage}",
          toastLength: Toast.LENGTH_SHORT,
          gravity: ToastGravity.BOTTOM,
          timeInSecForIosWeb: 1,
        );
      }
    } on DioException catch (e) {
      print(e);
      Fluttertoast.showToast(
        msg: "Failed to update: ${e.message}",
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

  Future<void> deleteVendorProductItem(int itemId) async {
    try {
      final box = await Hive.openBox<LoginResModel>('loginBox');
      final loginResModel = box.get('tokens');
      final response = await dio.delete('http://10.0.2.2:8000/api/v1/products/${itemId}/',
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