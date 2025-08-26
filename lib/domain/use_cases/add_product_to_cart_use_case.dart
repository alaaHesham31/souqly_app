import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/AddToCartResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class AddProductToCartUseCase{
  HomeRepository homeRepository;
  AddProductToCartUseCase({required this.homeRepository});

 Future<Either<Failures, AddToCartResponseEntity>> invoke(  String productId){
   return homeRepository.addProductToCart(productId);
 }

}