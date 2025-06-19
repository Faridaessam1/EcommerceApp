import '../../../domain/entities/subCategoryResponseEntity.dart';

class SubCategoryResponseDataModel extends SubCategoryResponseEntity {
  SubCategoryResponseDataModel({
    super.results,
    super.metadata,
    super.data,
    super.message,
    super.errors,
  });

  factory SubCategoryResponseDataModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryResponseDataModel(
      results: json['results'],
      metadata: json['metadata'] != null
          ? SubCategoryMetadataDataModel.fromJson(json['metadata'])
          : null,
      data: json['data'] != null
          ? List<SubCategoryDataDataModel>.from(
          json['data'].map((v) => SubCategoryDataDataModel.fromJson(v)))
          : null,
      message: json['message'],
      errors: json['errors'] != null
          ? SubCategoryErrorDataModel.fromJson(json['errors'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'results': results,
      'metadata': (metadata as SubCategoryMetadataDataModel?)?.toJson(),
      'data': data?.map((v) => (v as SubCategoryDataDataModel).toJson()).toList(),
      'message': message,
      'errors': (errors as SubCategoryErrorDataModel?)?.toJson(),
    };
  }

}

class SubCategoryErrorDataModel extends SubCategoryErrorEntity {
  SubCategoryErrorDataModel({
    super.value,
    super.msg,
    super.param,
    super.location,
  });

  factory SubCategoryErrorDataModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryErrorDataModel(
      value: json['value'],
      msg: json['msg'],
      param: json['param'],
      location: json['location'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'value': value,
      'msg': msg,
      'param': param,
      'location': location,
    };
  }
}


class SubCategoryDataDataModel extends SubCategoryDataEntity {
  SubCategoryDataDataModel({
    super.id,
    super.name,
    super.slug,
    super.category,
    super.createdAt,
    super.updatedAt,
  });

  factory SubCategoryDataDataModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryDataDataModel(
      id: json['_id'],
      name: json['name'],
      slug: json['slug'],
      category: json['category'],
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'name': name,
      'slug': slug,
      'category': category,
      'createdAt': createdAt,
      'updatedAt': updatedAt,
    };
  }
}

class SubCategoryMetadataDataModel extends SubCategoryMetadataEntity {
  SubCategoryMetadataDataModel({
    super.currentPage,
    super.numberOfPages,
    super.limit,
    super.nextPage,
  });

  factory SubCategoryMetadataDataModel.fromJson(Map<String, dynamic> json) {
    return SubCategoryMetadataDataModel(
      currentPage: json['currentPage'],
      numberOfPages: json['numberOfPages'],
      limit: json['limit'],
      nextPage: json['nextPage'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'currentPage': currentPage,
      'numberOfPages': numberOfPages,
      'limit': limit,
      'nextPage': nextPage,
    };
  }
}
