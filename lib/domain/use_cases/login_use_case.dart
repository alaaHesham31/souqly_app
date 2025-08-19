import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/LoginResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';
@injectable
class LoginUseCase{
  AuthRepository authRepository;
  LoginUseCase({required this.authRepository});

  Future<Either<Failures, LoginResponseEntity>> invoke(String email, String password){
    return authRepository.login(email, password);
  }
}