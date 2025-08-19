import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/LoginResponseEntity.dart';

abstract class LoginStates {}
 class LoginInitState extends LoginStates{}
class LoginLoadingState extends LoginStates{

}
class LoginErrorState extends LoginStates{
  Failures error;
  LoginErrorState({required this.error});
}
class LoginSuccessState extends LoginStates{
  LoginResponseEntity responseEntity;
  LoginSuccessState({required this.responseEntity});
}