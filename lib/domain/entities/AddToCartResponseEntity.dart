class AddToCartResponseEntity {
  AddToCartResponseEntity({
    this.status,
    this.message,
    this.numOfCartItems,
    this.cartId,
    this.data,
    this.statusMsg
  });

  String? status;
  String? message;
  num? numOfCartItems;
  String? cartId;
  OrderDataEntity? data;
  String? statusMsg;

}

class OrderDataEntity {
  OrderDataEntity({
    this.id,
    this.cartOwner,
    this.products,
    this.v,
    this.totalCartPrice,
  });

  String? id;
  String? cartOwner;
  List<AddCartProductsEntity>? products;

  num? v;
  num? totalCartPrice;
}

class AddCartProductsEntity {
  AddCartProductsEntity({
    this.count,
    this.id,
    this.product,
    this.price,
  });

  num? count;
  String? id;
  String? product;
  num? price;
}
