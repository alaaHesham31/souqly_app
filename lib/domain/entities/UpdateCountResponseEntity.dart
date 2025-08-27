import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';

class UpdateCountResponseEntity {
  UpdateCountResponseEntity({
      this.status, 
      this.numOfCartItems, 
      this.cartId, 
      this.data,});

  String? status;
  num? numOfCartItems;
  String? cartId;
  CountDataEntity? data;


}

class CountDataEntity {
  CountDataEntity({
      this.id, 
      this.cartOwner, 
      this.products, 
      this.createdAt, 
      this.updatedAt, 
      this.v, 
      this.totalCartPrice,});

  String? id;
  String? cartOwner;
  List<CartProductsEntity>? products;
  String? createdAt;
  String? updatedAt;
  num? v;
  num? totalCartPrice;


}

class CartProductsEntity {
  CartProductsEntity({
      this.count, 
      this.id, 
      this.product, 
      this.price,});

  num? count;
  String? id;
  ProductEntity? product;
  num? price;


}

