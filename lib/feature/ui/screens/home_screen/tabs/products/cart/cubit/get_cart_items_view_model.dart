import 'package:bloc/bloc.dart';
import 'package:e_commerce_app/domain/use_cases/delete_products_in_cart_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/get_products_in_cart_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/update_count_use_case.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/products/cubit/products_tab_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class GetCartItemsViewModel extends Cubit<ProductsTabStates> {
  final GetCartItemUseCase getCartItemUseCase;
  final DeleteCartItemUseCase deleteCartItemUseCase;
  UpdateCountUseCase updateCountUseCase;

  GetCartItemsViewModel({
    required this.getCartItemUseCase,
    required this.deleteCartItemUseCase,
    required this.updateCountUseCase,
  }) : super(GetCartLoadingState());

  static GetCartItemsViewModel get(context) => BlocProvider.of(context);

  Future<void> getCartItems() async {
    emit(GetCartLoadingState());
    final either = await getCartItemUseCase.invoke();
    either.fold(
      (error) => emit(GetCartErrorState(error: error)),
      (response) {

        emit(GetCartSuccessState(getCartResponseEntity: response));
      },
    );
  }

  Future<void> deleteCartItem(String cartItemId) async {
    emit(DeleteCartLoadingState());
    final either = await deleteCartItemUseCase.invoke(cartItemId);
    either.fold(
      (error) => emit(DeleteCartErrorState(error: error)),
      (response) {
        // Notify about deletion (for SnackBar), then push updated cart list
        emit(DeleteCartSuccessState(getCartResponseEntity: response));
        emit(GetCartSuccessState(getCartResponseEntity: response));
      },
    );
  }

  Future<void> updateCount(int count, String productId) async {
    final either = await updateCountUseCase.invoke(count, productId);
    either.fold(
      (error) => emit(UpdateCountErrorState(error: error)),
      (response) async {
        // Now re-fetch the whole cart so UI and total price update reliably
        final refreshed = await getCartItemUseCase.invoke();
        refreshed.fold(
          (err) => emit(GetCartErrorState(error: err)),
          (cartResponse) =>
              emit(GetCartSuccessState(getCartResponseEntity: cartResponse)),
        );
      },
    );
  }
}
