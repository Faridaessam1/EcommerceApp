class SubCategoryResponseEntity {
  int? results;
  SubCategoryMetadataEntity? metadata;
  List<SubCategoryDataEntity>? data;
  String? message;
  SubCategoryErrorEntity? errors;


  SubCategoryResponseEntity({
      this.results, 
      this.metadata, 
      this.data,
    this.message,
    this.errors,
  });

}

class SubCategoryErrorEntity {
  String? value;
  String? msg;
  String? param;
  String? location;

  SubCategoryErrorEntity({
    this.value,
    this.msg,
    this.param,
    this.location,
  });
}

class SubCategoryDataEntity{
  String? id;
  String? name;
  String? slug;
  String? category;
  String? createdAt;
  String? updatedAt;
  SubCategoryDataEntity({
      this.id, 
      this.name, 
      this.slug, 
      this.category, 
      this.createdAt, 
      this.updatedAt,});

}

class SubCategoryMetadataEntity {
  int? currentPage;
  int? numberOfPages;
  int? limit;
  int? nextPage;

  SubCategoryMetadataEntity({
      this.currentPage, 
      this.numberOfPages, 
      this.limit, 
      this.nextPage,});

}