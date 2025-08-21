import 'package:e_commerce_app/feature/ui/auth/login/login_screen.dart';
import 'package:e_commerce_app/feature/ui/auth/register/register_screen.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/product_details_screen.dart';
import 'package:e_commerce_app/feature/ui/screens/splash_screen.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/home_screen.dart';
import 'package:go_router/go_router.dart';

class AppRoutes {
  static const String splashScreen = "/init";
  static const String loginScreen = "/login";
  static const String signUpScreen = "/signUp";
  static const String homeScreen = "/home";
  static const String productDetailsScreen = "/detailsScreen";



  static GoRouter router = GoRouter(
    initialLocation: homeScreen ,
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
        builder: (context, state) => RegisterScreen(),
      ),
      GoRoute(
        path: homeScreen,
        builder: (context, state) => HomeScreen(),
      ),
      GoRoute(
        path: productDetailsScreen,
        builder: (context, state) => ProductDetailsScreen(),
      ),
    ],
  );
}
