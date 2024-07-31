import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:a2zjewelry/core/utils/env_components.dart';
import 'package:a2zjewelry/features/register/data/models/register_model.dart';

class RegisterRemoteDataSource {
  final Dio dio;

  RegisterRemoteDataSource(this.dio);

  Future<void> registerUser(RegisterModel model, BuildContext context) async {
    try {
      final response = await dio.post(
        '/api/v1/users/register/',
        data: model.toJson(),
      );

      if (response.statusCode == 200) {
        EnvComponents.showSuccessDialog(context, response.data);
        print('Registration successful: ${response.data}');
      } else {
        print('Registration failed: ${response.data}');
        EnvComponents.showErrorDialog(context, response.data);
      }
    } on DioException catch (e) {
      print('DioException: $e');
      EnvComponents.showErrorDialog(
          context, e.response?.data ?? 'An error occurred');
    } catch (e) {
      print('Error: $e');
      EnvComponents.showErrorDialog(context, e.toString());
    }
  }
}
