import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/domain/use_cases/add_product_to_cart_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_products_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_wish_list_use_case.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class ProductsTabViewModel extends Cubit<ProductsTabStates> {
  ProductsTabViewModel(
      {required this.productsUseCase, required this.addProductToCartUseCase, required this.getWishListUseCase})
      : super(ProductsInitState());
  GetAllProductsUseCase productsUseCase;
  AddProductToCartUseCase addProductToCartUseCase;
  GetWishListUseCase getWishListUseCase;
  List<ProductEntity> allProductsList = [];
  List<ProductEntity> filteredProductsList = [];

  int numOfCartItems = 0;
  List<String> subCategoriesList = [];
  int selectedIndex = 0;

  TextEditingController controller = TextEditingController();

  static ProductsTabViewModel get(context) => BlocProvider.of(context);

  getAllProducts() async {
    emit(ProductsLoadingState());
    var either = await productsUseCase.invoke();
    either.fold((error) {
      emit(ProductsErrorState(error: error));
    }, (response) {
      allProductsList = response.data!;
      filteredProductsList = List.from(allProductsList);

      emit(ProductsSuccessState(products: allProductsList));
    });
  }

  // get filtered products -- each for subCategory name
  void filterProductsBySubCategory(String? subCategory, int index) {
    selectedIndex = index;

    if (subCategory == null || subCategory.isEmpty) {
      filteredProductsList = List.from(allProductsList);
    } else {
      filteredProductsList = allProductsList.where((product) {
        return product.subcategory?.any((s) => s.name == subCategory) ?? false;
      }).toList();
    }

    emit(ProductsSuccessState(products: filteredProductsList));
  }




  addProductsToCart({required String productId}) async {
    var either = await addProductToCartUseCase.invoke(productId);
    either.fold((error) {
      emit(AddToCartErrorState(error: error));
    }, (response) {
      numOfCartItems = response.numOfCartItems!.toInt();
      emit(AddToCartSuccessState(addToCartResponseEntity: response));
    });
  }



}
