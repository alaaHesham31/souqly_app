import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/entities/GetCartResponseEntity.dart';
import 'package:e_commerce_app/domain/use_cases/get_products_in_cart_use_case.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartItemsViewModel extends Cubit<ProductsTabStates> {
  GetCartItemUseCase getCartItemUseCase;
  List<GetProductsInCartEntity> cartItems = [];

  GetCartItemsViewModel({required this.getCartItemUseCase})
      : super(GetCartInitState());

  static GetCartItemsViewModel get(context) => BlocProvider.of(context);

  getCartItem() async {
    emit(GetCartLoadingState());
    var either = await getCartItemUseCase.invoke();
    either.fold((error) {
      print('=====error: ${error.errorMessage}');
      emit(GetCartErrorState(error: error));
    }, (response) {
      cartItems = response.data!.products!;
      emit(GetCartSuccessState(getCartResponseEntity: response));
    });
  }
}
