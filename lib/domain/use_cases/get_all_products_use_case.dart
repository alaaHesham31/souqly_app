import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllProductsUseCase{
  HomeRepository homeRepository;
  GetAllProductsUseCase({required this.homeRepository});

 Future<Either<Failures, ProductsResponseEntity>> invoke(){
   return homeRepository.getAllProducts();
 }

}