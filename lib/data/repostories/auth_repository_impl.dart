import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/LoginResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/RegisterResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart';
import 'package:e_commerce_app/domain/repositories/repositories/auth_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: AuthRepository)
class AuthRepositoryImply implements AuthRepository {
  AuthRemoteDataSource authRemoteDataSource;
  AuthRepositoryImply({required this.authRemoteDataSource});
  @override
  Future<Either<Failures, RegisterResponseEntity>> register(String name,
      String phone, String email, String password, String rePassword)async {

    var either = await authRemoteDataSource.register(name, phone, email, password, rePassword);

    return either.fold((error) => Left(error), (response) => Right(response));

  }

  @override
  Future<Either<Failures, LoginResponseEntity>> login(String email, String password) async{
    var either = await authRemoteDataSource.login(email, password);

   return  either.fold((error) => Left(error), (response) => Right(response));


  }
}
