import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/AddToWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/GetWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/RemoveFromWishListEntity.dart';

abstract class WishListRepository {
  Future<Either<Failures, AddToWishListResponseEntity>> addToWishList(
      String productId);

  Future<Either<Failures, GetWishListResponseEntity>> getWishList();
  Future<Either<Failures, RemoveFromWishListEntity>> removeFromWishList(String productId);

}
