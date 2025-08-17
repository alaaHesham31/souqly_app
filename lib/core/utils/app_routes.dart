import 'package:e_commerce_app/feature/ui/auth/login/login_screen.dart';
import 'package:e_commerce_app/feature/ui/auth/sign%20up/sign_up_screen.dart';
import 'package:e_commerce_app/feature/ui/screens/splash_screen.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splashScreen = "/init";
  static const String loginScreen = "/login";
  static const String signUpScreen = "/signUp";
  static const String homeScreen = "/home";


  static GoRouter router = GoRouter(
    initialLocation: splashScreen,
    routes: [
      GoRoute(
        path: splashScreen,
        builder: (context, state) => SplashScreen(),
      ),
      GoRoute(
        path: loginScreen,
        builder: (context, state) => LoginScreen(),
      ),
      GoRoute(
        path: signUpScreen,
        builder: (context, state) => SignUpScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
    ],
  );
}
