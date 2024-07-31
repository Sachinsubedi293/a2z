import 'package:a2zjewelry/features/login/data/models/login_model.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:a2zjewelry/core/utils/env_components.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginRemote {
  final Dio dio;

  LoginRemote(this.dio);

  Future<void> loginRemoteUser(LoginModel model, BuildContext context) async {
    try {
      final response = await dio.post(
        '/api/v1/users/login/',
        data: model.toJson(),
      );

      if (response.statusCode == 200 && response.data['error_code'] == 0) {
        EnvComponents.showSuccessDialog(context, response.data['message']);
        print('Login successful: ${response.data}');

        LoginResModel loginResModel =
            LoginResModel.fromJson(response.data['data']);

        var box = await Hive.openBox<LoginResModel>('loginBox');
        await box.put('tokens', loginResModel);
      } else {
        print('Login failed: ${response.data}');
        EnvComponents.showErrorDialog(context, response.data['message']);
      }
    } on DioException catch (e) {
      print('DioException: $e');
      EnvComponents.showErrorDialog(
          context, e.response?.data ?? 'An error occurred');
    } catch (e) {
      print('Error: $e');
      EnvComponents.showErrorDialog(context, e.toString());
    }
    return null;
  }
}
