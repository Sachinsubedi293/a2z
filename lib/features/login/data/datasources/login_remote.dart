import 'package:a2zjewelry/features/login/data/models/login_model.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:a2zjewelry/router/app_router.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:a2zjewelry/core/utils/env_components.dart';
import 'package:hive_flutter/hive_flutter.dart';

class LoginRemote {
  final Dio dio;
  late final Box<LoginResModel> loginBox;
  late final Box<ProfileResModel> profileBox;

  LoginRemote(this.dio) {
    _initHiveBoxes();
  }

  Future<void> _initHiveBoxes() async {
    loginBox = await Hive.openBox<LoginResModel>('loginBox');
    profileBox = await Hive.openBox<ProfileResModel>('profileBox');
  }

  Future<void> loginRemoteUser(LoginModel model, BuildContext context) async {
    try {
      final response = await dio.post(
        '/api/v1/users/login/',
        data: model.toJson(),
      );

      if (response.statusCode == 200 && response.data['error_code'] == 0) {
        if (kDebugMode) {
          print('Login successful: ${response.data}');
        }

        LoginResModel loginResModel =
            LoginResModel.fromJson(response.data['data']);
        await loginBox.put('tokens', loginResModel);
        if (context.mounted) {
          if (await EnvComponents.showSuccessDialog(
              context, response.data['message'])) {
            if (context.mounted) {
              if (await fetchUserProfile(context)) {
                if (context.mounted) {
                NavigationService.goHome();
                }
              }
            }
          }
        }
      } else {
        if (kDebugMode) {
          print('Login failed: ${response.data}');
        }
        if (context.mounted) {
        EnvComponents.showErrorDialog(
            context, response.data['message'] ?? 'Login failed');}
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: $e');
      }
      if (context.mounted) {
      EnvComponents.showErrorDialog(
          context, e.response?.data ?? 'An error occurred');}
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      if (context.mounted) {
      EnvComponents.showErrorDialog(context, e.toString());}
    }
  }

  Future<bool> fetchUserProfile(BuildContext context) async {
    try {
      final loginResModel = loginBox.get('tokens');

      if (loginResModel?.accessToken != null) {
        final response = await dio.get(
          '/api/v1/users/profile/',
          options: Options(
            headers: {
              'Authorization': 'Bearer ${loginResModel!.accessToken}',
            },
          ),
        );

        if (response.statusCode == 200 && response.data['error_code'] == 0) {
          if (kDebugMode) {
            print('Profile data: ${response.data}');
          }

          ProfileResModel profileResModel =
              ProfileResModel.fromJson(response.data['data']);
          await profileBox.put('profile', profileResModel);

          return true; 
        } else {
          if (kDebugMode) {
            print('Failed to fetch profile: ${response.data}');
          }
          await loginBox.clear();
          if (context.mounted) {
          EnvComponents.showErrorDialog(
              context, response.data['message'] ?? 'Failed to fetch profile');
              }
        }
      } else {
        if (kDebugMode) {
          print('No valid token found');
        }
        await loginBox.clear();
        EnvComponents.showErrorDialog(context, 'No valid token found');

      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: $e');
      }
      if (context.mounted) {
      EnvComponents.showErrorDialog(
          context, e.response?.data ?? 'An error occurred');}
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      await loginBox.clear();
      if (context.mounted) {
      EnvComponents.showErrorDialog(context, e.toString());}
    }
    return false;
  }
}
