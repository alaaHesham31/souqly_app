import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/core/utils/app_assets.dart';
import 'package:e_commerce_app/domain/entities/CategoryOrBrandEntity.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_brands_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_all_categories_use_case.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/home/cubit/home_tab_states.dart';
import 'package:flutter/material.dart';
import 'package:injectable/injectable.dart';

@injectable
class HomeTabViewModel extends Cubit<HomeTabStates> {
  GetAllCategoriesUseCase categoriesUseCase;
  GetAllBrandsUseCase brandsUseCase;


  HomeTabViewModel({required this.categoriesUseCase, required this.brandsUseCase}) : super(HomeTabInitState());
  TextEditingController controller = TextEditingController();

  List<String> images =[
    AppAssets.announcement1,
    AppAssets.announcement2,
    AppAssets.announcement3,
  ];

  List<CategoryOrBrandDataEntity> categoriesList = [];
  List<CategoryOrBrandDataEntity> brandsList = [];


  getAllCategories() async {
    emit(CategoriesLoadingState());

    var either = await categoriesUseCase.invoke();
    either.fold((error) {
      emit(CategoriesErrorState(error: error));
    }, (response) {
      categoriesList = response.data!;
      emit(CategoriesSuccessState(categoryOrBrandEntity: response));

    });
  }

  getAllBrands() async {
    emit(BrandsLoadingState());

    var either = await brandsUseCase.invoke();
    either.fold((error) {
      emit(BrandsErrorState(error: error));
    }, (response) {
      brandsList = response.data!;
      emit(BrandsSuccessState(categoryOrBrandEntity: response));

    });
  }
}
