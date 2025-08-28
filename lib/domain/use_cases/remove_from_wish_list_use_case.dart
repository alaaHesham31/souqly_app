import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/RemoveFromWishListEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/wish_list/wish_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class RemoveFromWishListUseCase {
  WishListRepository removeFromWishListRepository;
  RemoveFromWishListUseCase({required this.removeFromWishListRepository});

  Future<Either<Failures, RemoveFromWishListEntity>>  invoke(String productId){
    return removeFromWishListRepository.removeFromWishList(productId);
  }
}