import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';

abstract class ProductsTabStates{}
class ProductsInitState extends ProductsTabStates{}

class ProductsLoadingState extends ProductsTabStates{}

class ProductsErrorState extends ProductsTabStates{
  Failures error;
  ProductsErrorState({required this.error});
}

class ProductsSuccessState extends ProductsTabStates{
  ProductsResponseEntity productsResponse;
  ProductsSuccessState({required this.productsResponse});
}
