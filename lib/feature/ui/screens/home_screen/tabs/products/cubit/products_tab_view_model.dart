import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsTabViewModel extends Cubit<ProductsTabStates>{
  ProductsTabViewModel({required this.productsUseCase}): super(ProductsInitState());
  GetAllProductsUseCase productsUseCase;
  List<ProductEntity> allProductsList = [];
  TextEditingController controller = TextEditingController();


  getAllProducts()async{
    emit(ProductsLoadingState());
    var either = await productsUseCase.invoke();
    either.fold((error) {
      emit(ProductsErrorState(error: error));

    }, (response){
      allProductsList = response.data!;
      emit(ProductsSuccessState(productsResponse: response));
    });
  }

}