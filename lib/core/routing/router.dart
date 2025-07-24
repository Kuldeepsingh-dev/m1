import 'package:go_router/go_router.dart';
import 'package:m1/features/auth/login/view/login_view.dart';
import 'package:m1/features/home/view/home.dart';
import 'package:m1/features/onboarding/splash.dart';
import 'app_routes.dart';

final router = GoRouter(
  initialLocation: AppRoutes.splash,
  routes: [
    GoRoute(
      path: AppRoutes.splash,
      builder: (context, state) => const SplashScreen(),
    ),

     GoRoute(
      path: AppRoutes.login,
      builder: (context, state) => const LoginView(),
    ),
   
     GoRoute(
      path: AppRoutes.home,
      builder: (context, state) => const HomeScreen(),
    ),
   
  ],
);
