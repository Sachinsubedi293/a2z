import 'package:hive_flutter/hive_flutter.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';

class ProfileLocalDataSource {
  late final Box<ProfileResModel> profileBox;
  late final Box<LoginResModel> loginBox;

  Future<void> initHiveBoxes() async {
    loginBox = await Hive.openBox<LoginResModel>('loginBox');
    profileBox = await Hive.openBox<ProfileResModel>('profileBox');
  }

  Future<void> saveProfile(ProfileResModel profile) async {
    await profileBox.put('profile', profile);
  }

  Future<void> clearHiveBoxes() async {
    await loginBox.clear();
    await profileBox.clear();
  }

  Future<LoginResModel?> getLoginResModel() async {
    return loginBox.get('tokens');
  }
}
