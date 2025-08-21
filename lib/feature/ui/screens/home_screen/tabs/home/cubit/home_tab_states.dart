import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/CategoryOrBrandEntity.dart';

abstract class HomeTabStates {}

class HomeTabInitState extends HomeTabStates {}

class CategoriesLoadingState extends HomeTabStates {}

class CategoriesErrorState extends HomeTabStates {
  Failures error;

  CategoriesErrorState({required this.error});
}

class CategoriesSuccessState extends HomeTabStates {
  CategoryOrBrandEntity categoryOrBrandEntity;

  CategoriesSuccessState({required this.categoryOrBrandEntity});
}


class BrandsLoadingState extends HomeTabStates {}

class BrandsErrorState extends HomeTabStates {
  Failures error;

  BrandsErrorState({required this.error});
}

class BrandsSuccessState extends HomeTabStates {
  CategoryOrBrandEntity categoryOrBrandEntity;

  BrandsSuccessState({required this.categoryOrBrandEntity});
}