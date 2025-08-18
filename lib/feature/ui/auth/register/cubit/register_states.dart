import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/RegisterResponseEntity.dart';

abstract class RegisterStates{}

class RegisterInitState extends RegisterStates {}
class RegisterLoadingState extends RegisterStates {

}
class RegisterSuccessState extends RegisterStates {
  RegisterResponseEntity responseEntity ;
RegisterSuccessState({required this.responseEntity});
}
class RegisterErrorState extends RegisterStates {
  Failures error;
  RegisterErrorState({required this.error});
}

