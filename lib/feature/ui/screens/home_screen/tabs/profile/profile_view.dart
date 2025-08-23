import 'package:e_commerce_app/core/shared_prefrences/shared_preferences_utils.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';

class ProfileView extends StatelessWidget {
  const ProfileView({super.key});

  Future<void> logout(BuildContext context) async {
    await SharedPreferencesUtils.removeData(key: 'token');
    if (!context.mounted) return;
    context.go(AppRoutes.loginScreen);  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: IconButton(
          onPressed: () async {
            await logout(context);
          },
          icon: const Icon(Icons.logout, color: AppColors.primaryColor),
        ),
      ),
    );
  }
}
