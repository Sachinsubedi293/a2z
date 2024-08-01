import 'package:a2zjewelry/core/temp/pages/temp_page.dart';
import 'package:a2zjewelry/features/forgot_password/presentation/pages/forgot_page.dart';
import 'package:a2zjewelry/features/homepage/presentation/pages/home_page.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/login/presentation/pages/login_page.dart';
import 'package:a2zjewelry/features/profile/presentation/pages/profile_Page.dart';
import 'package:a2zjewelry/features/register/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    redirect: (context, state) {
      final box = Hive.box<LoginResModel>('loginBox');
      final token = box.get('tokens');

      if (token == null || token.accessToken == null) {
        return '/login';
      }
      return '/home';
    },
    routes: [
      GoRoute(
        path: '/test',
        builder: (context, state) => ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => RegisterPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => LoginPage(),
      ),
      GoRoute(
        path: '/forgot',
        builder: (context, state) => ForgotPage(),
      ),
      GoRoute(path: '/home', builder: (context, state) => HomePage(), routes: [
        GoRoute(
          path: 'profile',
          builder: (context, state) => ProfilePage(),
        ),
      ]),
    ],
  );
}
