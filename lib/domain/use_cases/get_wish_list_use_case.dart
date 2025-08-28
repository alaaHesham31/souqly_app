import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/GetWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/wish_list/wish_list_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetWishListUseCase {
  WishListRepository getWishListRepository;
  GetWishListUseCase({required this.getWishListRepository});

  Future<Either<Failures, GetWishListResponseEntity>>  invoke(){
    return getWishListRepository.getWishList();
  }
}