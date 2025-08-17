import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  TextEditingController nameController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  TextEditingController phoneController = TextEditingController();

  TextEditingController rePasswordController = TextEditingController();

  TextEditingController emailController = TextEditingController();

  final formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    nameController.dispose();
    passwordController.dispose();
    rePasswordController.dispose();
    phoneController.dispose();
    emailController.dispose();
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
                  height: 200.h,
                ),
                Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.start,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      Text(
                        'Full Name ',
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: nameController,
                        hintText: 'enter your full name',
                        validator: Validators.validateName,

                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'Mobile Number',
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: phoneController,
                        hintText: 'enter your mobile no.',
                        keyboardType: TextInputType.phone,
                        validator: Validators.validatePhone,

                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'E-mail address',
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: emailController,
                        hintText: 'enter your email address',
                        keyboardType: TextInputType.emailAddress,
                        validator: Validators.validateEmail,
                      ),
                      SizedBox(
                        height: 12.h,
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
                        hintText: 'enter your password ',
                        obscureText: true,
                        suffixIcon: Image.asset(AppAssets.viewIcon),
                        validator: Validators.validatePassword,
                      ),
                      SizedBox(
                        height: 12.h,
                      ),
                      Text(
                        'Re-Password',
                        style: AppStyles.medium18White,
                      ),
                      SizedBox(
                        height: 8.h,
                      ),
                      CustomTextField(
                        controller: rePasswordController,
                        hintText: 're-enter your password',
                        obscureText: true,
                        suffixIcon: Image.asset(AppAssets.viewIcon),
                        validator: (value) => Validators.validateRePassword(value, passwordController.text),
                      ),
                      SizedBox(
                        height: 32.h,
                      ),
                      CustomElevatedButton(
                        text: 'Sign Up',
                        onPressed: () {
                          if (formKey.currentState!.validate()) {
                            debugPrint("Name : $nameController");
                            debugPrint("phone : $phoneController");
                            debugPrint("email : $emailController");
                            debugPrint("password : $passwordController");
                            debugPrint("re-password : $rePasswordController");
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
                    context.go(AppRoutes.loginScreen);
                  },
                  child: Text(
                    'Have an account? Login',
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
