import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/AddToWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/GetWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/RemoveFromWishListEntity.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/wish_list_remote_data_source.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/wish_list/wish_list_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: WishListRepository)
class AddToWishListRepositoryImpl implements WishListRepository {
  WishListRemoteDataSource wishListRemoteDataSource;

  AddToWishListRepositoryImpl({required this.wishListRemoteDataSource});

  @override
  Future<Either<Failures, AddToWishListResponseEntity>> addToWishList(
      String productId) async {
    var either = await wishListRemoteDataSource.addToWishList(productId);
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, GetWishListResponseEntity>> getWishList() async{
    var either = await wishListRemoteDataSource.getWishList();
    return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, RemoveFromWishListEntity>> removeFromWishList(String productId) async{
    var either = await wishListRemoteDataSource.removeFromWishList(productId);
    return either.fold((error) => Left(error), (response) => Right(response));
  }


}
