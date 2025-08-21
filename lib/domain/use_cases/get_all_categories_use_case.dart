import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/CategoryOrBrandEntity.dart';
import 'package:e_commerce_app/domain/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetAllCategoriesUseCase{
  HomeRepository homeRepository;
  GetAllCategoriesUseCase({required this.homeRepository});

 Future<Either<Failures, CategoryOrBrandEntity>> invoke(){
   return homeRepository.getAllCategories();
 }

}