import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/UpdateCountResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/update_count_remore_data_source.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/cart/update_count_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: UpdateCountRepository)
class UpdateCountRepositoryImpl implements UpdateCountRepository {
  UpdateCountRemoteDataSource updateCountRemoteDataSource;

  UpdateCountRepositoryImpl({required this.updateCountRemoteDataSource});

  @override
  Future<Either<Failures, UpdateCountResponseEntity>> updateProductCountInCart(
      int count, String productId) async {
    var either = await
        updateCountRemoteDataSource.updateProductCountInCart(count, productId);
    return either.fold((error) => Left(error), (response) => Right(response));
  }
}
