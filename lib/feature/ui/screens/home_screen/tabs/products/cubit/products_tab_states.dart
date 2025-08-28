import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/AddToCartResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/AddToWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/UpdateCountResponseEntity.dart';

abstract class ProductsTabStates {}

class ProductsInitState extends ProductsTabStates {}

class ProductsLoadingState extends ProductsTabStates {}

class ProductsErrorState extends ProductsTabStates {
  Failures error;

  ProductsErrorState({required this.error});
}

class ProductsSuccessState extends ProductsTabStates {
  ProductsResponseEntity productsResponse;

  ProductsSuccessState({required this.productsResponse});
}

class AddToCartLoadingState extends ProductsTabStates {}

class AddToCartErrorState extends ProductsTabStates {
  Failures error;

  AddToCartErrorState({required this.error});
}

class AddToCartSuccessState extends ProductsTabStates {
  AddToCartResponseEntity addToCartResponseEntity;

  AddToCartSuccessState({required this.addToCartResponseEntity});
}

class GetCartInitState extends ProductsTabStates {}

class GetCartLoadingState extends ProductsTabStates {}

class GetCartErrorState extends ProductsTabStates {
  Failures error;

  GetCartErrorState({required this.error});
}

class GetCartSuccessState extends ProductsTabStates {
  GetCartResponseEntity getCartResponseEntity;

  GetCartSuccessState({required this.getCartResponseEntity});
}

class DeleteCartInitState extends ProductsTabStates {}

class DeleteCartLoadingState extends ProductsTabStates {}

class DeleteCartErrorState extends ProductsTabStates {
  Failures error;

  DeleteCartErrorState({required this.error});
}

class DeleteCartSuccessState extends ProductsTabStates {
  GetCartResponseEntity getCartResponseEntity;

  DeleteCartSuccessState({required this.getCartResponseEntity});
}

// new

class UpdateCountLoadingState extends ProductsTabStates {}

class UpdateCountErrorState extends ProductsTabStates {
  Failures error;

  UpdateCountErrorState({required this.error});
}

class UpdateCountSuccessState extends ProductsTabStates {
  UpdateCountResponseEntity updateCountEntity;

  UpdateCountSuccessState({required this.updateCountEntity});
}

class AddToWishListErrorState extends ProductsTabStates{
  Failures error;
  AddToWishListErrorState({required this.error});
}

class AddToWishListSuccessState extends ProductsTabStates{
  AddToWishListResponseEntity addToWishListResponseEntity;
  AddToWishListSuccessState({required this.addToWishListResponseEntity});
}
