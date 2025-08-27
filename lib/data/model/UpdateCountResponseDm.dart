import 'package:e_commerce_app/data/model/ProductsResponseDm.dart';
import 'package:e_commerce_app/domain/entities/UpdateCountResponseEntity.dart';

class UpdateCountResponseDm extends UpdateCountResponseEntity{
  UpdateCountResponseDm({
      super.status,
    super.numOfCartItems,
    super.cartId,
    super.data,
  this.statusMsg,
  this.message});

  UpdateCountResponseDm.fromJson(dynamic json) {
    status = json['status'];
    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    data = json['data'] != null ? CountDataDm.fromJson(json['data']) : null;
  }

String? message;
  String? statusMsg;


}

class CountDataDm extends CountDataEntity{
  CountDataDm({
    super.id,
    super.cartOwner,
    super.products,
    super.createdAt,
    super.updatedAt,
    super.v,
    super.totalCartPrice,});

  CountDataDm.fromJson(dynamic json) {
    id = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(CartProductsDm.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }



}

class CartProductsDm extends CartProductsEntity{
  CartProductsDm({
    super.count,
    super.id,
    super.product,
    super.price,});

  CartProductsDm.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product = json['product'] != null ? ProductDm.fromJson(json['product']) : null;
    price = json['price'];
  }


}

