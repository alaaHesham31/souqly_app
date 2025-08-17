import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  TextEditingController userController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    userController.dispose();
    passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: AppColors.primaryColor,
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.all(12.0),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.start,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Image(
                  image: AssetImage(AppAssets.appLogo),
                  height: 300.h,
                ),

                Text(
                  'Welcome Back',
                  style: AppStyles.semiBold24White,
                ),
                SizedBox(
                  height: 8.h,
                ),
                Text(
                  'Please sign in with your mail',
                  style: AppStyles.light16White,
                ),
                SizedBox(
                  height: 20.h,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'User',
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: userController,
                        hintText: 'enter your name',
                        keyboardType: TextInputType.emailAddress,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      Text(
                        'Password',
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: passwordController,
                        hintText: 'enter your password',
                        obscureText: true,
                        suffixIcon: Image.asset(AppAssets.viewIcon),
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'Forgot password',
                        style: AppStyles.regular18White,
                        textAlign: TextAlign.end,
                      ),
                      SizedBox(
                        height: 24.h,
                      ),
                      CustomElevatedButton(
                        text: 'Login',
                        onPressed: () {
                          context.go(AppRoutes.homeScreen);

                          if(formKey.currentState!.validate()){
                            debugPrint("userName : $userController");
                            debugPrint("password : $passwordController");

                          }
                        },
                        textStyle: AppStyles.semiBold20Primary,
                        borderRadius: 16,
                        color: AppColors.whiteColor,
                      ),
                    ],
                  ),
                ),
                SizedBox(
                  height: 24.h,
                ),
                InkWell(
                  onTap: () {
                    context.go(AppRoutes.signUpScreen);
                  },
                  child: Text(
                    'Don’t have an account? Create Account',
                    style: AppStyles.medium18White,
                    textAlign: TextAlign.center,
                  ),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
