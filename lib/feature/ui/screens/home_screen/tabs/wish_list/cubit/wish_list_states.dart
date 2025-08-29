import 'package:e_commerce_app/core/utils/failures.dart';
import 'package:e_commerce_app/domain/entities/GetWishListResponseEntity.dart';
import 'package:e_commerce_app/domain/entities/RemoveFromWishListEntity.dart';

abstract class WishListStates {}

class WishListInitState extends WishListStates {}

class WishListLoadingState extends WishListStates {}

class WishListErrorState extends WishListStates {
  Failures error;

  WishListErrorState({required this.error});
}

class WishListSuccessState extends WishListStates {
GetWishListResponseEntity getWishListResponseEntity;
  WishListSuccessState({required this.getWishListResponseEntity});
}

class WishListIdsLoadedState extends WishListStates {
  List<String> wishListIds;
  WishListIdsLoadedState({required this.wishListIds});
}


class RemoveWishListLoadingState extends WishListStates {}

class RemoveWishListErrorState extends WishListStates {
  Failures error;

  RemoveWishListErrorState({required this.error});
}

class RemoveWishListSuccessState extends WishListStates {
  RemoveFromWishListEntity removeFromWishListEntity;
  RemoveWishListSuccessState({required this.removeFromWishListEntity});
}