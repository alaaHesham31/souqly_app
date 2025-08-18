import 'package:e_commerce_app/core/di/di.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/core/utils/app_colors.dart';
import 'package:e_commerce_app/core/utils/app_routes.dart';
import 'package:e_commerce_app/core/utils/app_styles.dart';
import 'package:e_commerce_app/core/utils/dialog_utils.dart';
import 'package:e_commerce_app/core/utils/validators.dart';
import 'package:e_commerce_app/feature/ui/auth/register/cubit/register_states.dart';
import 'package:e_commerce_app/feature/ui/auth/register/cubit/register_view_model.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_elevated_button.dart';
import 'package:e_commerce_app/feature/ui/widgets/custom_text_field.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:go_router/go_router.dart';

class RegisterScreen extends StatefulWidget {
  const RegisterScreen({super.key});

  @override
  State<RegisterScreen> createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  RegisterViewModel viewModel = getIt<RegisterViewModel>();

  @override
  void dispose() {
    viewModel.nameController.dispose();
    viewModel.passwordController.dispose();
    viewModel.rePasswordController.dispose();
    viewModel.phoneController.dispose();
    viewModel.emailController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<RegisterViewModel, RegisterStates>(
      bloc: viewModel,
      listener: (context, state) {
        if (state is RegisterLoadingState) {

          DialogUtils.showLoading(context);
        } else if (state is RegisterErrorState) {

          DialogUtils.hideLoading(context);
          DialogUtils.showErrorDialog(context,  title: 'Error' ,message:  state.error.errorMessage);
        } else if (state is RegisterSuccessState) {
          DialogUtils.hideLoading(context);

          DialogUtils.showSuccessDialog(
              context, message: 'Account Created Successfully');
        }
      },
      child: GestureDetector(
        onTap: () {
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
                    key: viewModel.formKey,
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
                          controller: viewModel.nameController,
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
                          controller: viewModel.phoneController,
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
                          controller: viewModel.emailController,
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
                          controller: viewModel.passwordController,
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
                          controller: viewModel.rePasswordController,
                          hintText: 're-enter your password',
                          obscureText: true,
                          suffixIcon: Image.asset(AppAssets.viewIcon),
                          validator: (value) => Validators.validateRePassword(
                              value, viewModel.passwordController.text),
                        ),
                        SizedBox(
                          height: 32.h,
                        ),
                        CustomElevatedButton(
                          text: 'Sign Up',
                          onPressed: () {
                            viewModel.register();
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
      ),
    );
  }
}
