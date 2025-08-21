import 'package:dartz/dartz.dart';
import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/CategoryOrBrandEntity.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart';
import 'package:e_commerce_app/domain/repositories/home/home_repository.dart';
import 'package:injectable/injectable.dart';

@Injectable(as: HomeRepository)
class HomeRepositoryImpl implements HomeRepository{
  HomeRemoteDataSource homeRemoteDataSource;
  HomeRepositoryImpl({required this.homeRemoteDataSource});

  @override
  Future<Either<Failures, CategoryOrBrandEntity>> getAllCategories() async{
   var either = await homeRemoteDataSource.getAllCategories();
   return either.fold((error) => Left(error), (response) => Right(response));
  }

  @override
  Future<Either<Failures, CategoryOrBrandEntity>> getAllBrands() async{
    var either = await homeRemoteDataSource.getAllBrands();
    return either.fold((error) => Left(error), (response) => Right((response)));
  }

  @override
  Future<Either<Failures, ProductsResponseEntity>> getAllProducts() async{
    var either = await homeRemoteDataSource.getAllProducts();
    return either.fold((error) => Left(error), (response) => Right((response)));
  }

}