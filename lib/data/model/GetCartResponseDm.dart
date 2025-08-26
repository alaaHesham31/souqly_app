import 'package:e_commerce_app/data/model/ProductsResponseDm.dart';
import 'package:e_commerce_app/domain/entities/GetCartResponseEntity.dart';

class GetCartResponseDm extends GetCartResponseEntity {
  GetCartResponseDm(
      {super.status,
      super.numOfCartItems,
      super.cartId,
      super.data,
      this.message,
      this.statusMsg});

  GetCartResponseDm.fromJson(dynamic json) {
    status = json['status'];
    statusMsg = json['statusMsg'];
    message = json['message'];

    numOfCartItems = json['numOfCartItems'];
    cartId = json['cartId'];
    data = json['data'] != null ? GetCartDataDm.fromJson(json['data']) : null;
  }

  String? statusMsg;
  String? message;
}

class GetCartDataDm extends GetCartDataEntity {
  GetCartDataDm({
    super.id,
    super.cartOwner,
    super.products,
    super.createdAt,
    super.updatedAt,
    super.v,
    super.totalCartPrice,
  });

  GetCartDataDm.fromJson(dynamic json) {
    id = json['_id'];
    cartOwner = json['cartOwner'];
    if (json['products'] != null) {
      products = [];
      json['products'].forEach((v) {
        products?.add(GetProductsInCartDm.fromJson(v));
      });
    }
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
    v = json['__v'];
    totalCartPrice = json['totalCartPrice'];
  }
}

class GetProductsInCartDm extends GetProductsInCartEntity {
  GetProductsInCartDm({
    super.count,
    super.id,
    super.product,
    super.price,
  });

  GetProductsInCartDm.fromJson(dynamic json) {
    count = json['count'];
    id = json['_id'];
    product =
        json['product'] != null ? ProductDm.fromJson(json['product']) : null;
    price = json['price'];
  }
}
