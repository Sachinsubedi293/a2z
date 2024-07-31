import 'package:a2zjewelry/features/forgot_password/presentation/pages/forgot_page.dart';
import 'package:a2zjewelry/features/login/presentation/pages/login_page.dart';
import 'package:a2zjewelry/features/register/presentation/pages/register_page.dart';
import 'package:go_router/go_router.dart';

class AppRouter {
  static final GoRouter router = GoRouter(
    initialLocation: '/login',
    routes: [
      GoRoute(
        path: '/register',
        builder: (context, state) =>RegisterPage(),
      ),
      GoRoute(
          path: '/login',
          builder: (context, state) => LoginPage(),
          routes: [
            GoRoute(
              path: 'forgot',
              builder: (context, state) => ForgotPage(),
            ),
          ]),
    ],
  );
}
