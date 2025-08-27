import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/UpdateCountResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/cart/update_count_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class UpdateCountUseCase {
  UpdateCountRepository updateCountRepository;

  UpdateCountUseCase({required this.updateCountRepository});

  Future<Either<Failures, UpdateCountResponseEntity>> invoke(
      int count, String productId) {
    return updateCountRepository.updateProductCountInCart(count, productId);
  }
}
