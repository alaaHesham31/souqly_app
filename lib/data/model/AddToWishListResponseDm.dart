import 'package:e_commerce_app/domain/entities/AddToWishListResponseEntity.dart';

class AddToWishListResponseDm extends AddToWishListResponseEntity {
  AddToWishListResponseDm({
    super.status,
    super.message,
    super.data,
  });

  AddToWishListResponseDm.fromJson(dynamic json) {
    status = json['status'];
    message = json['message'];
    data = json['data'] != null ? json['data'].cast<String>() : [];
  }
}
