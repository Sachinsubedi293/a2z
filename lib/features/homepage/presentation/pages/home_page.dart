import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late Future<Box<LoginResModel>> _boxFuture;

  @override
  void initState() {
    super.initState();
    _boxFuture = Hive.openBox<LoginResModel>('loginBox');
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text("Homepage"),
      ),
      body: FutureBuilder<Box<LoginResModel>>(
        future: _boxFuture,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return Center(child: CircularProgressIndicator());
          } else if (snapshot.hasError) {
            return Center(child: Text('Error: ${snapshot.error}'));
          } else if (snapshot.hasData) {
            final box = snapshot.data!;
            final loginResModel = box.get('tokens') as LoginResModel?;
            final token = loginResModel?.accessToken ?? 'Guest';

            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text("Hello $token! Welcome"),
                  ElevatedButton(
                      onPressed: () {
                        context.go('/home/profile');
                      },
                      child: Text("Check Your Profile"))
                ],
              ),
            );
          } else {
            return Center(child: Text('No data found'));
          }
        },
      ),
      drawer: Drawer(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Padding(
              padding: EdgeInsets.all(20),
              child: ElevatedButton(
                  onPressed: () {
                    clearBoxAndLogout();
                  },
                  child: Text('Logout')),
            )
          ],
        ),
      ),
    );
  }

  Future<void> clearBoxAndLogout() async {
    try {
      final box = await _boxFuture;
      await box.clear(); 
      context.go('/login'); 
    } catch (e) {
      print('Error clearing box: $e');
    }
  }
}
