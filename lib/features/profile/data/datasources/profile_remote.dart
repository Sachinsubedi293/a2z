import 'dart:io';
import 'package:a2zjewelry/features/profile/data/datasources/profile_local.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:dio/dio.dart';
import 'package:flutter/foundation.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_model.dart';

class ProfileRemote {
  final Dio dio;
  final ProfileLocalDataSource localDataSource;

  ProfileRemote(this.dio, this.localDataSource);

  Future<void> updateUser(ProfileModel model, File? avatarFile) async {
    try {
      final formDataMap = {
        'email': model.email,
        'first_name': model.first_name,
        'last_name': model.last_name,
        'bio': model.bio,
        if (avatarFile != null)
          'avatar': await MultipartFile.fromFile(avatarFile.path),
      };

      final formData = FormData.fromMap(formDataMap);
      final loginResModel = await localDataSource.getLoginResModel();
      
      final response = await dio.patch(
        '/api/v1/users/profiles/28/',
        data: formData,
        options: Options(
          headers: {
            'Authorization': 'Bearer ${loginResModel?.accessToken}',
          },
        ),
      );

      Fluttertoast.showToast(msg: response.data['message']);
      // Fetch user profile after update
      await fetchUserProfile();
    } on DioException catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    } catch (e) {
      Fluttertoast.showToast(msg: e.toString());
    }
  }

  Future<bool> fetchUserProfile() async {
    try {
      final loginResModel = await localDataSource.getLoginResModel();

      final response = await dio.get(
        '/api/v1/users/profile/',
        options: Options(
          headers: {
            'Authorization': 'Bearer ${loginResModel?.accessToken}',
          },
        ),
      );

      if (response.statusCode == 200 && response.data['error_code'] == 0) {
        if (kDebugMode) {
          print('Profile data: ${response.data}');
        }

        // Parse the profile data from response
        ProfileResModel profileResModel =
            ProfileResModel.fromJson(response.data['data']);
        
        // Save to local storage
        await localDataSource.saveProfile(profileResModel);

        return true;
      } else {
        if (kDebugMode) {
          print('Failed to fetch profile: ${response.data}');
        }
        // Clear local storage if fetch fails
        await localDataSource.clearHiveBoxes();
        return false;
      }
    } on DioException catch (e) {
      if (kDebugMode) {
        print('DioException: $e');
      }
      return false;
    } catch (e) {
      if (kDebugMode) {
        print('Error: $e');
      }
      return false;
    }
  }
}
