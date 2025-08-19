import 'package:bloc/bloc.dart';

import 'package:e_commerce_app/domain/use_cases/login_use_case.dart';
import 'package:e_commerce_app/feature/ui/auth/login/cubit/login_states.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class LoginViewModel extends Cubit<LoginStates> {
  LoginUseCase loginUseCase;

  LoginViewModel({required this.loginUseCase}) : super(LoginInitState());
  final formKey = GlobalKey<FormState>();
  TextEditingController emailController = TextEditingController();

  TextEditingController passwordController = TextEditingController();

  void login() async {

    if (formKey.currentState!.validate()) {
      var either = await loginUseCase.invoke(
          emailController.text, passwordController.text);
      emit(LoginLoadingState());
      either.fold((error) {
        emit(LoginErrorState(error: error));
      }, (response) {
        emit(LoginSuccessState(responseEntity: response));
      });
    }

  }
}
