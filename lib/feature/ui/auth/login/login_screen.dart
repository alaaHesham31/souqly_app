import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/dialog_utils.dart';
import 'package:e_commerce_app/feature/ui/auth/login/cubit/login_states.dart';
import 'package:e_commerce_app/feature/ui/auth/login/cubit/login_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class LoginScreen extends StatefulWidget {
  LoginScreen({super.key});

  @override
  State<LoginScreen> createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  LoginViewModel viewModel = getIt<LoginViewModel>();
  @override
  void dispose() {
    viewModel.emailController.dispose();
    viewModel.passwordController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<LoginViewModel, LoginStates>(
      bloc: viewModel,
      listener:(context, state){
        if(state is LoginLoadingState){
          DialogUtils.showLoading(context,message:  'waiting');
        }else if(state is LoginErrorState) {
          DialogUtils.hideLoading(context);
          DialogUtils.showErrorDialog(context, message: state.error.errorMessage);
        }else if(state is LoginSuccessState){
          DialogUtils.hideLoading(context);
          DialogUtils.showSuccessSnackBar(context, state.responseEntity.message);
          WidgetsBinding.instance.addPostFrameCallback((_) {
            context.go(AppRoutes.homeScreen);
          });
        }
      } ,
      child: GestureDetector(
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
                    key: viewModel.formKey,
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
                          controller: viewModel.emailController,
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
                          controller: viewModel.passwordController,
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
                            viewModel.login();


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
      ),
    );
  }
}
