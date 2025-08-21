class CategoryOrBrandEntity {
  CategoryOrBrandEntity({
      this.results, 
      this.metadata, 
      this.data,
  this.statusMsg});

  int? results;
  MetadataEntity? metadata;
  List<CategoryOrBrandDataEntity>? data;
 String? statusMsg;

}

class CategoryOrBrandDataEntity {
  CategoryOrBrandDataEntity({
      this.id, 
      this.name, 
      this.slug, 
      this.image, 
    });

  String? id;
  String? name;
  String? slug;
  String? image;


}

class MetadataEntity {
  MetadataEntity({
      this.currentPage, 
      this.numberOfPages, 
      this.limit,});

  int? currentPage;
  int? numberOfPages;
  int? limit;


}