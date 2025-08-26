import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/cart_remote_data_source.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/cart/cart_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: CartRepository)
class CartRepositoryImpl extends CartRepository{
  CartRemoteDataSource cartRemoteDataSource;
  CartRepositoryImpl({required this.cartRemoteDataSource});
  @override
  Future<Either<Failures, GetCartResponseEntity>> getCartItems() async{
    var either = await cartRemoteDataSource.getCartItems();
     return either.fold((error) => Left(error), (response) => Right(response));
  }
}