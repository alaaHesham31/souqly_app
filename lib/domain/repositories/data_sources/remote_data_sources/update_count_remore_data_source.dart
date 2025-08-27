import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/UpdateCountResponseEntity.dart';

abstract class UpdateCountRemoteDataSource{
  Future<Either<Failures, UpdateCountResponseEntity>> updateProductCountInCart(int count, String productId);

}