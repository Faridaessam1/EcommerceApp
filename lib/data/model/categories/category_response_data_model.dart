import 'package:e_commerce_app/domain/entities/category_response_entity.dart';

class CategoryResponseDataModel extends CategoryResponseEntity {
  String? message;
  String? statusMsg;
  CategoryResponseDataModel({
    this.statusMsg,
    this.message,
      super.results,
      super.metadata,
      super.categoryData,
  });

  CategoryResponseDataModel.fromJson(dynamic json) {
    results = json['results'];
    statusMsg = json['statusMsg'];
    message = json['message'];
    metadata = (json['metadata'] != null ? MetadataDataModel.fromJson(json['metadata']) : null);
    if (json['data'] != null) {
      categoryData = [];
      json['data'].forEach((v) {
        categoryData?.add(CategoryDataDataModel.fromJson(v) );
      });
    }
  }

  Map<String, dynamic> toJson() {
    return {
      'statusMsg': statusMsg,
      'message': message,
      'results': results,
      'metadata': (metadata as MetadataDataModel?)?.toJson(),
      'data': categoryData
          ?.map((e) => (e as CategoryDataDataModel).toJson())
          .toList(),
    };
  }



}

class CategoryDataDataModel extends CategoryDataEntity{
  CategoryDataDataModel({
      super.id,
      super.name,
      super.slug,
      super.image,
      super.createdAt,
      super.updatedAt,
  });

  CategoryDataDataModel.fromJson(dynamic json) {
    id = json['_id'];
    name = json['name'];
    slug = json['slug'];
    image = json['image'];
    createdAt = json['createdAt'];
    updatedAt = json['updatedAt'];
  }
  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'image': image,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }


}

class MetadataDataModel extends MetadataEntity{
  MetadataDataModel({
      super.currentPage,
      super.numberOfPages,
      super.limit,
  });

  MetadataDataModel.fromJson(dynamic json) {
    currentPage = json['currentPage'];
    numberOfPages = json['numberOfPages'];
    limit = json['limit'];
  }
  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'numberOfPages': numberOfPages,
      'limit': limit,
    };
  }
}