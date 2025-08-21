import 'package:e_commerce_app/domain/entities/CategoryOrBrandEntity.dart';

class CategoryOrBrandDm extends CategoryOrBrandEntity {
  CategoryOrBrandDm({
    super.results,
    super.metadata,
    super.data,
    super.statusMsg
  });

  CategoryOrBrandDm.fromJson(dynamic json) {
    results = json['results'];
    statusMsg = json['statusMsg'];

    metadata =
        json['metadata'] != null ? MetadataDm.fromJson(json['metadata']) : null;
    if (json['data'] != null) {
      data = [];
      json['data'].forEach((v) {
        data?.add(CategoryOrBrandDataDm.fromJson(v));
      });
    }
  }
}

class CategoryOrBrandDataDm extends CategoryOrBrandDataEntity {
  CategoryOrBrandDataDm({
    super.id,
    super.name,
    super.slug,
    super.image,
    this.createdAt,
    this.updatedAt,
  });

  CategoryOrBrandDataDm.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }

  String? createdAt;
  String? updatedAt;
}

class MetadataDm extends MetadataEntity {
  MetadataDm({
    super.currentPage,
    super.numberOfPages,
    super.limit,
  });

  MetadataDm.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
  }
}
