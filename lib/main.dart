import 'package:a2zjewelry/app.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:flutter/material.dart';
import 'package:flutter_riverpod/flutter_riverpod.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';

Future<void> initHive() async {
  await Hive.initFlutter();
  Hive.registerAdapter(LoginResModelAdapter()); 
    Hive.registerAdapter(ProfileResModelAdapter());
await Hive.openBox<LoginResModel>('loginBox');
await Hive.openBox<ProfileResModel>('profileBox');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initHive();

  runApp( ProviderScope(child: MyApp()));
}



