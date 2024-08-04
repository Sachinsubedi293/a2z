import 'package:a2zjewelry/features/404page/presentation/pages/404page.dart';
import 'package:a2zjewelry/features/forgot_password/presentation/pages/forgot_page.dart';
import 'package:a2zjewelry/features/mainpage/presentation/pages/main_page.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/login/presentation/pages/login_page.dart';
import 'package:a2zjewelry/features/profile/presentation/pages/profile_page.dart';
import 'package:a2zjewelry/features/register/presentation/pages/register_page.dart';
import 'package:a2zjewelry/features/homepage/presentation/pages/home_page.dart';
import 'package:a2zjewelry/features/category/presentation/pages/category_page.dart';
import 'package:a2zjewelry/features/search_product/presentation/pages/search_page.dart';
import 'package:a2zjewelry/features/cart/presentation/pages/cart_page.dart';
import 'package:a2zjewelry/features/wishlist/presentation/pages/wish_list_page.dart';
import 'package:flutter/material.dart';
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
      
      if (state.matchedLocation == '/login' || state.matchedLocation == '/register') {
        if (token == null || token.accessToken == null) {
          return null; // Allow access to login/register
        }
        return '/start/home'; // Redirect to home if logged in
      }
      
      if (token == null || token.accessToken == null) {
        return '/login';
      }
      
      return null; // No redirection needed
    },
    routes: [
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
      ShellRoute(
        builder: (context, state, child) => MainPage(child: child),
        routes: [
          GoRoute(
            path: '/start/home',
            builder: (context, state) => HomePage(),
          ),
          GoRoute(
            path: '/start/categories',
            builder: (context, state) => CategoriesPage(),
          ),
          GoRoute(
            path: '/start/search',
            builder: (context, state) => SearchPage(),
          ),
          GoRoute(
            path: '/start/cart',
            builder: (context, state) => CartPage(),
          ),
          GoRoute(
            path: '/start/wishlist',
            builder: (context, state) => WishlistPage(),
          ),
          GoRoute(
            path: '/start/profile',
            builder: (context, state) => ProfilePage(),
          ),
        ],
      ),
    ],
    errorBuilder: (context, state) {
      return PageNotFound(); // Handle 404 page
    },
  );
}

class NavigationService {
  static final GoRouter _router = AppRouter().router;

  static void goLogin() {
    _router.go('/login');
  }

  static void goRegister() {
    _router.go('/register');
  }

  static void goForgot() {
    _router.go('/forgot');
  }

  static void goHome() {
    _router.go('/start/home');
  }

  static void goToProfile() {
    _router.go('/start/profile');
  }

  static void goToCategories() {
    _router.go('/start/categories');
  }

  static void goToSearch() {
    _router.go('/start/search');
  }

  static void goToCart() {
    _router.go('/start/cart');
  }

  static void goToWishlist() {
    _router.go('/start/wishlist');
  }
}
