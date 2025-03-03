class CategoryResponseEntity {
  int? results;
  MetadataEntity? metadata;
  List<CategoryDataEntity>? categoryData;

  CategoryResponseEntity({
    this.results,
    this.metadata,
    this.categoryData,
  });

}

class CategoryDataEntity {
  String? id;
  String? name;
  String? slug;
  String? image;
  String? createdAt;
  String? updatedAt;


  CategoryDataEntity({
       this.id,
      this.name,
      this.slug,
      this.image,
     this.createdAt,
      this.updatedAt,
  });

}

class MetadataEntity {
  int? currentPage;
  int? numberOfPages;
  int? limit;

  MetadataEntity({
      this.currentPage,
      this.numberOfPages,
      this.limit,
  });
}