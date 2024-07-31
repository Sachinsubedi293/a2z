import 'package:a2zjewelry/features/login/data/models/login_model.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:a2zjewelry/core/utils/env_components.dart';

class LoginRemote {
  final Dio dio;

  LoginRemote(this.dio);

  Future<LoginResModel?> loginRemoteUser(LoginModel model, BuildContext context) async {
    try {
      final response = await dio.post(
        '/api/v1/users/login/',
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        EnvComponents.showSuccessDialog(context, response.data);
        print('Registration successful: ${response.data}');
        return LoginResModel.fromJson(response.data);
      } else {
        print('Registration failed: ${response.data}');
        EnvComponents.showErrorDialog(context, response.data);
        return null;
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
