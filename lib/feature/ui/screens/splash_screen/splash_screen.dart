import 'package:e_commerce_app/core/shared_prefrences/shared_preferences_utils.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();
    Future.delayed(const Duration(seconds: 3), () {
      if (mounted) {
        _checkLogin();
      }
    });
  }

  Future<void> _checkLogin() async {
    final token = SharedPreferencesUtils.getString('token') ;

    if (token != null && token.isNotEmpty) {
      context.go(AppRoutes.homeScreen);
    } else {
      context.go(AppRoutes.loginScreen);
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: double.infinity,
        height: double.infinity,
        color: AppColors.primaryColor,
        child: Stack(
          children: [
            // Top white radial gradient
            Align(
              alignment: Alignment.topCenter,
              child: Container(
                width: double.infinity,
                height: 500.h,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.topCenter,
                    radius: 1.0,
                    colors: [
                      AppColors.white54Color,
                      AppColors.transparentColor,
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
            ),

            // Bottom white radial gradient
            Align(
              alignment: Alignment.bottomCenter,
              child: Container(
                width: double.infinity,
                height: 500.h,
                decoration: const BoxDecoration(
                  gradient: RadialGradient(
                    center: Alignment.bottomCenter,
                    radius: 1.0,
                    colors: [
                      AppColors.white54Color,
                      AppColors.transparentColor,
                    ],
                    stops: [0.0, 1.0],
                  ),
                ),
              ),
            ),

            // Logo in center
            Center(child: Image(image: AssetImage(AppAssets.appLogo))),
          ],
        ),
      ),
    );
  }
}
