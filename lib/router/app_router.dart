import 'package:a2zjewelry/core/temp/test_widget.dart';
import 'package:a2zjewelry/features/404page/presentation/pages/404page.dart';
import 'package:a2zjewelry/features/cart/presentation/pages/cart_page.dart';
import 'package:a2zjewelry/features/category/presentation/pages/category_page.dart';
import 'package:a2zjewelry/features/forgot_password/presentation/pages/forgot_page.dart';
import 'package:a2zjewelry/features/homepage/presentation/pages/home_page.dart';
import 'package:a2zjewelry/features/login/data/models/login_res_model.dart';
import 'package:a2zjewelry/features/login/presentation/pages/login_page.dart';
import 'package:a2zjewelry/features/mainpage/presentation/pages/main_page.dart';
import 'package:a2zjewelry/features/product/presentation/pages/product_detail_page.dart';
import 'package:a2zjewelry/features/profile/presentation/pages/profile_page.dart';
import 'package:a2zjewelry/features/register/presentation/pages/register_page.dart';
import 'package:a2zjewelry/features/product/presentation/pages/search_page.dart';
import 'package:a2zjewelry/features/vendor/presentation/pages/own_product_page.dart';
import 'package:a2zjewelry/features/vendor/presentation/pages/vendor_analytic_page.dart';
import 'package:a2zjewelry/features/vendor/presentation/pages/vendor_edit_product_page.dart';
import 'package:a2zjewelry/features/vendor/presentation/pages/vendor_main_page.dart';
import 'package:a2zjewelry/features/vendor/presentation/pages/vendor_product_create_page.dart';
import 'package:a2zjewelry/features/wishlist/presentation/pages/wish_list_page.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:jwt_decoder/jwt_decoder.dart';

class AppRouter {
  final GlobalKey<NavigatorState> _rootNavigatorKey =
      GlobalKey<NavigatorState>();

  GoRouter get router => GoRouter(
        navigatorKey: _rootNavigatorKey,
        initialLocation: '/login',
        redirect: (context, state) {
          final box = Hive.box<LoginResModel>('loginBox');
          final token = box.get('tokens');
          print(state.fullPath);
          if (token?.accessToken != null && state.fullPath == '/login'&&!JwtDecoder.isExpired(token!.accessToken!)) {
           // return '/start/home';
            return '/orders';
          }
          return null;
        },
        routes: [
          ShellRoute(
              builder: (context, state, child) => VendorMainPage(child: child),
              routes: [
                GoRoute(
                  path: '/vendor/analytics',
                  builder: (context, state) => VendorAnalyticsPage(),
                ),
                GoRoute(
                  path: '/vendor/add',
                  builder: (context, state) => ProductFormPage(),
                ),
                GoRoute(
                  path: '/vendor/products',
                  builder: (context, state) => OwnProductsPage(),
                ),
              ]),
              GoRoute(path: '/orders',builder: (context, state) => OrderListPage(),),
          GoRoute(
            path: '/profile',
            builder: (context, state) => const ProfilePage(),
          ),
          GoRoute(
            path: '/edit/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return EditProductPage(productId: id);
            },
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
          GoRoute(
            path: '/details/:id',
            builder: (context, state) {
              final id = int.parse(state.pathParameters['id']!);
              return ProductDetailPage(id: id);
            },
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
            ],
          ),
        ],
        errorBuilder: (context, state) {
          return const PageNotFound();
        },
      );
}
