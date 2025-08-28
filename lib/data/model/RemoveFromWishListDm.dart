import 'package:e_commerce_app/domain/entities/RemoveFromWishListEntity.dart';

class RemoveFromWishListDm extends RemoveFromWishListEntity{
  RemoveFromWishListDm({
      super.status,
      super.message,
      super.data,});

  RemoveFromWishListDm.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }
}