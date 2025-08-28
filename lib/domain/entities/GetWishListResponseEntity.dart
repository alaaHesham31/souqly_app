import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';

class GetWishListResponseEntity {
  GetWishListResponseEntity({
      this.status, 
      this.count, 
      this.data,});

  String? status;
  num? count;
  List<ProductEntity>? data;


}

