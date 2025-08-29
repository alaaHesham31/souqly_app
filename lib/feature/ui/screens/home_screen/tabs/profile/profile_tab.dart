import 'package:e_commerce_app/core/shared_prefrences/shared_preferences_utils.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  Future<void> logout(BuildContext context) async {
    await SharedPreferencesUtils.removeData(key: 'token');
    if (!context.mounted) return;
    context.go(AppRoutes.loginScreen);
  }

  TextEditingController nameController =
      TextEditingController(text: 'Alaa Hesham');
  TextEditingController emailController =
      TextEditingController(text: 'alaa@gmail.com');
  TextEditingController phoneController =
      TextEditingController(text: '01094568875');

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          title: Image(
            image: AssetImage(AppAssets.appLogo),
            color: AppColors.primaryColor,
            width: 200.w,
          ),
        ),
        body: Padding(
          padding: EdgeInsets.all(12.sp),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Column(
                      children: [
                        Text(
                          'Welcome, Alaa',
                          style: AppStyles.semiBold20Primary,
                        ),
                        Text(
                          'alaa.@gmail.com',
                          style: AppStyles.medium16Grey,
                        ),
                      ],
                    ),
                    Container(
                      decoration: BoxDecoration(
                          color: AppColors.whiteColor,
                          shape: BoxShape.circle,
                          boxShadow: [
                            BoxShadow(
                              color: AppColors.greyColor.withValues(alpha: 0.5),
                              blurRadius: 2,
                              offset: Offset(0, 2),
                            )
                          ]),
                      child: IconButton(
                        onPressed: () async {
                          await logout(context);
                        },
                        icon: const Icon(Icons.logout,
                            color: AppColors.primaryColor),
                      ),
                    ),
                  ],
                ),
                SizedBox(
                  height: 40.h,
                ),
                Text(
                  'Your full name',
                  style: AppStyles.medium18Primary,
                ),
                SizedBox(
                  height: 16.h,
                ),

                // TODO: Implement update profile feature once API is available.
                // These fields (name, email, phone) should be editable and updates
                // must be persisted via the backend API.

                CustomTextField(
                  controller: nameController,
                  suffixIcon: Icon(Icons.edit),
                  borderColor: AppColors.primaryColor,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  'Your E-mail',
                  style: AppStyles.medium18Primary,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextField(
                  controller: emailController,
                  suffixIcon: Icon(Icons.edit),
                  borderColor: AppColors.primaryColor,
                ),
                SizedBox(
                  height: 24.h,
                ),
                Text(
                  'Your mobile number',
                  style: AppStyles.medium18Primary,
                ),
                SizedBox(
                  height: 16.h,
                ),
                CustomTextField(
                  controller: phoneController,
                  suffixIcon: Icon(Icons.edit),
                  borderColor: AppColors.primaryColor,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
