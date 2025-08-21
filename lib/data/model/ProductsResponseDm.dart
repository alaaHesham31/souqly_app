import 'package:e_commerce_app/data/model/CategoryOrBrandDm.dart';
import 'package:e_commerce_app/domain/entities/ProductsResponseEntity.dart';

class ProductsResponseDm extends ProductsResponseEntity{
  ProductsResponseDm({
      super.results,
      super.metadata,
      super.data,
  this.statusMsg,
  this.message});

  ProductsResponseDm.fromJson(dynamic json) {
    results = json['results'];
    statusMsg = json['statusMsg'] ?? json['status'];
    message = json['message'];
    metadata = json['metadata'] != null ? MetadataDm.fromJson(json['metadata']) : null;
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

class ProductDm extends ProductEntity{
  ProductDm({
      super.sold,
    super.images,
    super.subcategory,
    super.ratingsQuantity,
    super.id,
    super.title,
    super.slug,
    super.description,
    super.quantity,
    super.price,
    super.imageCover,
    super.category,
    super.brand,
    super.ratingsAverage,
      this.createdAt, 
      this.updatedAt, 
     });

  ProductDm.fromJson(dynamic json) {
    sold = json['sold'];
    images = json['images'] != null ? json['images'].cast<String>() : [];
    if (json['subcategory'] != null) {
      subcategory = [];
      json['subcategory'].forEach((v) {
        subcategory?.add(SubcategoryDm.fromJson(v));
      });
    }
    ratingsQuantity = json['ratingsQuantity'];
    id = json['_id'] ?? json['id'];
    title = json['title'];
    slug = json['slug'];
    description = json['description'];
    quantity = json['quantity'];
    price = json['price'];
    imageCover = json['imageCover'];
    category = json['category'] != null ? CategoryOrBrandDataDm.fromJson(json['category']) : null;
    brand = json['brand'] != null ? CategoryOrBrandDataDm.fromJson(json['brand']) : null;
    ratingsAverage = json['ratingsAverage'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  String? createdAt;
  String? updatedAt;


}



class SubcategoryDm extends SubcategoryEntity{
  SubcategoryDm({
      super.id,
      super.name,
      super.slug,
      super.category,});

  SubcategoryDm.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    category = json['category'];
  }


}

class MetadataDm extends ProductMetadataEntity{
  MetadataDm({
      super.currentPage,
      super.numberOfPages,
      super.limit,
      super.nextPage});

  MetadataDm.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
    nextPage = json['nextPage'];
  }




}