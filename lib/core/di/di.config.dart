// dart format width=80
// GENERATED CODE - DO NOT MODIFY BY HAND

// **************************************************************************
// InjectableConfigGenerator
// **************************************************************************

// ignore_for_file: type=lint
// coverage:ignore-file

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'package:get_it/get_it.dart' as _i174;
import 'package:injectable/injectable.dart' as _i526;

import '../../data/data_sources/remote_data_sources_impl/auth_remote_data_source_impl.dart'
    as _i405;
import '../../data/data_sources/remote_data_sources_impl/home/cart/cart_remote_data_source_impl.dart'
    as _i62;
import '../../data/data_sources/remote_data_sources_impl/home/cart/update_count_remore_data_source_impl.dart'
    as _i483;
import '../../data/data_sources/remote_data_sources_impl/home/home_remote_data_source_impl.dart'
    as _i484;
import '../../data/repostories/auth_repository_impl.dart' as _i120;
import '../../data/repostories/home/cart/cart_repository_impl.dart' as _i46;
import '../../data/repostories/home/cart/update_count_repository_impl.dart'
    as _i80;
import '../../data/repostories/home/home_repository_impl.dart' as _i95;
import '../../domain/repositories/data_sources/remote_data_sources/auth_remote_data_source.dart'
    as _i327;
import '../../domain/repositories/data_sources/remote_data_sources/cart_remote_data_source.dart'
    as _i629;
import '../../domain/repositories/data_sources/remote_data_sources/home_remote_data_source.dart'
    as _i923;
import '../../domain/repositories/data_sources/remote_data_sources/update_count_remore_data_source.dart'
    as _i366;
import '../../domain/repositories/repositories/auth_repository.dart' as _i69;
import '../../domain/repositories/repositories/home/cart/cart_repository.dart'
    as _i653;
import '../../domain/repositories/repositories/home/cart/update_count_repository.dart'
    as _i953;
import '../../domain/repositories/repositories/home/home_repository.dart'
    as _i789;
import '../../domain/use_cases/add_product_to_cart_use_case.dart' as _i802;
import '../../domain/use_cases/delete_products_in_cart_use_case.dart' as _i918;
import '../../domain/use_cases/get_all_brands_use_case.dart' as _i773;
import '../../domain/use_cases/get_all_categories_use_case.dart' as _i201;
import '../../domain/use_cases/get_all_products_use_case.dart' as _i939;
import '../../domain/use_cases/get_products_in_cart_use_case.dart' as _i706;
import '../../domain/use_cases/login_use_case.dart' as _i471;
import '../../domain/use_cases/register_use_case.dart' as _i479;
import '../../domain/use_cases/update_count_use_case.dart' as _i49;
import '../../feature/ui/auth/login/cubit/login_view_model.dart' as _i761;
import '../../feature/ui/auth/register/cubit/register_view_model.dart' as _i552;
import '../../feature/ui/screens/home_screen/tabs/home/cubit/home_tab_view_model.dart'
    as _i463;
import '../../feature/ui/screens/home_screen/tabs/products/cart/cubit/get_cart_items_view_model.dart'
    as _i952;
import '../../feature/ui/screens/home_screen/tabs/products/cubit/products_tab_view_model.dart'
    as _i80;
import '../api/api_manager.dart' as _i1047;

extension GetItInjectableX on _i174.GetIt {
// initializes the registration of main-scope dependencies inside of GetIt
  _i174.GetIt init({
    String? environment,
    _i526.EnvironmentFilter? environmentFilter,
  }) {
    final gh = _i526.GetItHelper(
      this,
      environment,
      environmentFilter,
    );
    gh.singleton<_i1047.ApiManager>(() => _i1047.ApiManager());
    gh.factory<_i923.HomeRemoteDataSource>(() =>
        _i484.HomeRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i366.UpdateCountRemoteDataSource>(() =>
        _i483.UpdateCountRemoteDataSourceImpl(
            apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i629.CartRemoteDataSource>(() =>
        _i62.CartRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i327.AuthRemoteDataSource>(() =>
        _i405.AuthRemoteDataSourceImpl(apiManager: gh<_i1047.ApiManager>()));
    gh.factory<_i789.HomeRepository>(() => _i95.HomeRepositoryImpl(
        homeRemoteDataSource: gh<_i923.HomeRemoteDataSource>()));
    gh.factory<_i802.AddProductToCartUseCase>(() =>
        _i802.AddProductToCartUseCase(
            homeRepository: gh<_i789.HomeRepository>()));
    gh.factory<_i773.GetAllBrandsUseCase>(() =>
        _i773.GetAllBrandsUseCase(homeRepository: gh<_i789.HomeRepository>()));
    gh.factory<_i201.GetAllCategoriesUseCase>(() =>
        _i201.GetAllCategoriesUseCase(
            homeRepository: gh<_i789.HomeRepository>()));
    gh.factory<_i939.GetAllProductsUseCase>(() => _i939.GetAllProductsUseCase(
        homeRepository: gh<_i789.HomeRepository>()));
    gh.factory<_i953.UpdateCountRepository>(() =>
        _i80.UpdateCountRepositoryImpl(
            updateCountRemoteDataSource:
                gh<_i366.UpdateCountRemoteDataSource>()));
    gh.factory<_i80.ProductsTabViewModel>(() => _i80.ProductsTabViewModel(
          productsUseCase: gh<_i939.GetAllProductsUseCase>(),
          addProductToCartUseCase: gh<_i802.AddProductToCartUseCase>(),
        ));
    gh.factory<_i653.CartRepository>(() => _i46.CartRepositoryImpl(
        cartRemoteDataSource: gh<_i629.CartRemoteDataSource>()));
    gh.factory<_i69.AuthRepository>(() => _i120.AuthRepositoryImply(
        authRemoteDataSource: gh<_i327.AuthRemoteDataSource>()));
    gh.factory<_i463.HomeTabViewModel>(() => _i463.HomeTabViewModel(
          categoriesUseCase: gh<_i201.GetAllCategoriesUseCase>(),
          brandsUseCase: gh<_i773.GetAllBrandsUseCase>(),
        ));
    gh.factory<_i471.LoginUseCase>(
        () => _i471.LoginUseCase(authRepository: gh<_i69.AuthRepository>()));
    gh.factory<_i479.RegisterUseCase>(
        () => _i479.RegisterUseCase(authRepository: gh<_i69.AuthRepository>()));
    gh.factory<_i706.GetCartItemUseCase>(() =>
        _i706.GetCartItemUseCase(cartRepository: gh<_i653.CartRepository>()));
    gh.factory<_i918.DeleteCartItemUseCase>(() => _i918.DeleteCartItemUseCase(
        cartRepository: gh<_i653.CartRepository>()));
    gh.factory<_i49.UpdateCountUseCase>(() => _i49.UpdateCountUseCase(
        updateCountRepository: gh<_i953.UpdateCountRepository>()));
    gh.factory<_i761.LoginViewModel>(
        () => _i761.LoginViewModel(loginUseCase: gh<_i471.LoginUseCase>()));
    gh.factory<_i552.RegisterViewModel>(() =>
        _i552.RegisterViewModel(authUseCase: gh<_i479.RegisterUseCase>()));
    gh.factory<_i952.GetCartItemsViewModel>(() => _i952.GetCartItemsViewModel(
          getCartItemUseCase: gh<_i706.GetCartItemUseCase>(),
          deleteCartItemUseCase: gh<_i918.DeleteCartItemUseCase>(),
          updateCountUseCase: gh<_i49.UpdateCountUseCase>(),
        ));
    return this;
  }
}
