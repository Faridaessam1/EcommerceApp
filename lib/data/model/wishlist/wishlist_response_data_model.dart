import 'package:e_commerce_app/domain/entities/wishlist_response_entity.dart';
import '../categories/category_response_data_model.dart';
import '../subCategories/sub_category_response_data_model.dart';

class WishlistResponseDM extends WishlistResponseEntity {
  WishlistResponseDM({
    super.status,
    super.count,
    super.data,
  });

  factory WishlistResponseDM.fromJson(Map<String, dynamic> json) {
    return WishlistResponseDM(
      status: json['status'],
      count: json['count'],
      data: (json['data'] as List<dynamic>?)
          ?.map((e) => WishlistDataDM.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'status': status,
      'count': count,
      'data': data?.map((e) => (e as WishlistDataDM).toJson()).toList(),
    };
  }
}

class WishlistDataDM extends WishlistDataEntity {
  WishlistDataDM({
    super.sId,
    super.title,
    super.description,
    super.quantity,
    super.imageCover,
    super.images,
    super.price,
    super.ratingsAverage,
    super.ratingsQuantity,
    super.category,
    super.subcategory,
  });

  factory WishlistDataDM.fromJson(Map<String, dynamic> json) {
    return WishlistDataDM(
      sId: json['_id'],
      title: json['title'],
      description: json['description'],
      quantity: json['quantity'],
      imageCover: json['imageCover'],
      images: (json['images'] as List<dynamic>?)?.cast<String>(),
      price: json['price'],
      ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble(),
      ratingsQuantity: json['ratingsQuantity'],
      category: json['category'] != null
          ? CategoryResponseDataModel.fromJson(json['category'])
          : null,
      subcategory: (json['subcategory'] as List<dynamic>?)
          ?.map((e) => SubCategoryResponseDataModel.fromJson(e))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': sId,
      'title': title,
      'description': description,
      'quantity': quantity,
      'imageCover': imageCover,
      'images': images,
      'price': price,
      'ratingsAverage': ratingsAverage,
      'ratingsQuantity': ratingsQuantity,
      'category': (category as CategoryResponseDataModel?)?.toJson(),
      'subcategory': subcategory
          ?.map((e) => (e as SubCategoryResponseDataModel).toJson())
          .toList(),
    };
  }
}
