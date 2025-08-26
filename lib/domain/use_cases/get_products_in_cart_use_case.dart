import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartItemUseCase {
  CartRepository cartRepository;

  GetCartItemUseCase({required this.cartRepository});

  Future<Either<Failures, GetCartResponseEntity>> invoke() {
    return cartRepository.getCartItems();
  }
}
