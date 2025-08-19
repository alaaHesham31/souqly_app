import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/use_cases/register_use_case.dart';
import 'package:e_commerce_app/feature/ui/auth/register/cubit/register_states.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class RegisterViewModel extends Cubit<RegisterStates> {
  RegisterUseCase authUseCase;

  TextEditingController nameController = TextEditingController();
  TextEditingController passwordController = TextEditingController();
  TextEditingController phoneController = TextEditingController();
  TextEditingController rePasswordController = TextEditingController();
  TextEditingController emailController = TextEditingController();
  final formKey = GlobalKey<FormState>();

  RegisterViewModel({required this.authUseCase}) : super(RegisterInitState());

  void register() async {
    if (formKey.currentState!.validate()) {
      emit(RegisterLoadingState());
      var either = await authUseCase.invoke(
          nameController.text,
          phoneController.text,
          emailController.text,
          passwordController.text,
          rePasswordController.text);
      either.fold((error) {
        emit(RegisterErrorState(error: error));
      }, (response) {
        emit(RegisterSuccessState(responseEntity: response));
      });
    }
  }

}
