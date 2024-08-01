import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/profile/data/models/profile_res_model.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Box<ProfileResModel>> _profileBoxFuture;
  late Future<Box<LoginResModel>> _loginBoxFuture;

  @override
  void initState() {
    super.initState();
    _loginBoxFuture = Hive.openBox<LoginResModel>('loginBox');

    _profileBoxFuture = Hive.openBox<ProfileResModel>('profileBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Homepage"),
      ),
      body: FutureBuilder<Box<ProfileResModel>>(
        future: _profileBoxFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final box = snapshot.data!;
            final profileResModel = box.get('profile');
            final email = profileResModel?.email ?? 'User';

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hello $email! Welcome"),
                  const SizedBox(
                    height: 20,
                  ),
                  ElevatedButton(
                      onPressed: () {
                        context.go('/home/profile');
                      },
                      child: const Text("Check Your Profile"))
                ],
              ),
            );
          } else {
            return const Center(child: Text('No profile data found'));
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: const EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    clearBoxAndLogout();
                  },
                  child: const Text('Logout')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> clearBoxAndLogout() async {
    try {
      final box = await _loginBoxFuture;
      await box.clear();
      if (context.mounted) {
        context.go('/login');
      }
    } catch (e) {
      if (kDebugMode) {
        print('Error clearing box: $e');
      }
    }
  }
}
