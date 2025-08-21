import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/CategoryOrBrandEntity.dart';

abstract class HomeRepository{

 Future<Either<Failures, CategoryOrBrandEntity>> getAllCategories();
 Future<Either<Failures, CategoryOrBrandEntity>> getAllBrands();


}