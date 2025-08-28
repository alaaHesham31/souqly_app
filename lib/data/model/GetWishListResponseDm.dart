import 'package:e_commerce_app/data/model/ProductsResponseDm.dart';
import 'package:e_commerce_app/domain/entities/GetWishListResponseEntity.dart';

class GetWishListResponseDm extends GetWishListResponseEntity {
  GetWishListResponseDm(
      {super.status, super.count, super.data, this.message, this.statusMsg});

  GetWishListResponseDm.fromJson(dynamic json) {
    status = json['status'];
    statusMsg = json['statusMsg'];
    message = json['message'];
    count = json['count'];
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(ProductDm.fromJson(v));
      });
    }
  }

  String? statusMsg;
  String? message;
}
