import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';
import 'package:e_commerce_app/domain/use_cases/get_wish_list_use_case.dart';
import 'package:e_commerce_app/domain/use_cases/remove_from_wish_list_use_case.dart';
import 'package:e_commerce_app/feature/ui/screens/home_screen/tabs/wish_list/cucit/wish_list_states.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';

@injectable
class WishListViewModel extends Cubit<WishListStates> {
  GetWishListUseCase getWishListUseCase;
  RemoveFromWishListUseCase removeFromWishListUseCase;
  List<ProductEntity> wishList = [];
  List<String> wishListIds = [];

  WishListViewModel(
      {required this.getWishListUseCase,
      required this.removeFromWishListUseCase})
      : super(WishListInitState());

  static WishListViewModel get(context) => BlocProvider.of(context);

  getWishList() async {
    emit(WishListLoadingState());
    var either = await getWishListUseCase.invoke();
    return either.fold((error) {
      emit(WishListErrorState(error: error));
    }, (response) {
      wishList = response.data ?? [];
      emit(WishListSuccessState(getWishListResponseEntity: response));
    });
  }

  removeFromWishList(String productId) async {
    var either = await removeFromWishListUseCase.invoke(productId);
    return either.fold((error) => emit(RemoveWishListErrorState(error: error)),
        (response) {
      wishList.removeWhere((product) => productId == product.id);
      wishListIds.remove(productId);

      emit(RemoveWishListSuccessState(removeFromWishListEntity: response));


        });
  }

  void fetchWishlist() async {
    final response = await getWishListUseCase.invoke(); // API
    response.fold((error) {
      emit(WishListErrorState(error: error));
    }, (wishlistResponse) {
      // wishlistResponse.data is List<ProductEntity>
      wishListIds = (wishlistResponse.data ?? [])
          .map((product) => product.id ?? "")
          .toList();

      emit(WishListIdsLoadedState(wishListIds: wishListIds));
    });
  }
}
