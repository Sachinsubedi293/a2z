import 'package:a2zjewelry/core/temp/pages/temp_page.dart';
import 'package:a2zjewelry/features/forgot_password/presentation/pages/forgot_page.dart';
import 'package:a2zjewelry/features/homepage/presentation/pages/home_page.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/login/presentation/pages/login_page.dart';
import 'package:a2zjewelry/features/profile/presentation/pages/profile_Page.dart';
import 'package:a2zjewelry/features/register/presentation/pages/register_page.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';

class AppRouter {

  final GlobalKey<NavigatorState> _rootNavigatorKey = GlobalKey<NavigatorState>();

  GoRouter get router => GoRouter(
    navigatorKey: _rootNavigatorKey,
    initialLocation: '/login',
    redirect: (context, state) {
      final box = Hive.box<LoginResModel>('loginBox');
      final token = box.get('tokens');
      

      if (state.matchedLocation=='/login') {
        if (token == null || token.accessToken == null) {
        return '/login';
      }
      return '/home';
      }
      return null;
    },
    routes: [
      GoRoute(
        path: '/test',
        builder: (context, state) => const ForgotPasswordPage(),
      ),
      GoRoute(
        path: '/register',
        builder: (context, state) => const RegisterPage(),
      ),
      GoRoute(
        path: '/login',
        builder: (context, state) => const LoginPage(),
      ),
      GoRoute(
        path: '/forgot',
        builder: (context, state) => const ForgotPage(),
      ),
      GoRoute(path: '/home', builder: (context, state) => const HomePage(), routes: [
        GoRoute(
          path: 'profile',
          builder: (context, state) => const ProfilePage(),
        ),
      ]),
    ],
  );
  
}

class NavigationService {
  static final GoRouter _router = AppRouter().router;

  static void goLogin() {
    _router.go('/login');
  }

  static void goHome() {
    _router.go('/home');
  }
}