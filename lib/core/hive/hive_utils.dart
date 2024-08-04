import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HiveService {
  static final HiveService _instance = HiveService._internal();
  factory HiveService() => _instance;
  HiveService._internal();

  late Box<ProfileResModel> _profileBox;

  Future<void> init() async {
    await Hive.initFlutter();

    if (!Hive.isBoxOpen('profileBox')) {
      _profileBox = await Hive.openBox<ProfileResModel>('profileBox');
    } else {
      _profileBox = Hive.box<ProfileResModel>('profileBox');
    }
  }

  Box<ProfileResModel> get profileBox => _profileBox;
}
