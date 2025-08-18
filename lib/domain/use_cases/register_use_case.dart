import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/RegisterResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
 class RegisterUseCase {
  AuthRepository authRepository;

  RegisterUseCase({required this.authRepository});

  Future<Either<Failures, RegisterResponseEntity>> invoke(String name,
      String phone, String email, String password, String rePassword) {
    return authRepository.register(name, phone, email, password, rePassword);
  }
}
