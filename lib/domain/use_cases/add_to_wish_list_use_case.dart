import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/AddToWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/wish_list/wish_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddToWishListUseCase {
  WishListRepository addToWishListRepository;
  AddToWishListUseCase({required this.addToWishListRepository});

  Future<Either<Failures, AddToWishListResponseEntity>>  invoke(String productId){
    return addToWishListRepository.addToWishList(productId);
  }
}