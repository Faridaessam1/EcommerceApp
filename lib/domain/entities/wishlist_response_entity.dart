import 'package:e_commerce_app/domain/entities/subCategoryResponseEntity.dart';
import 'category_response_entity.dart';

class WishlistResponseEntity {
  final String? status;
  final int? count;
  final List<WishlistDataEntity>? data;

  WishlistResponseEntity({
    this.status,
    this.count,
    this.data,
  });

}

class WishlistDataEntity {
  final String? sId;
  final String? title;
  final String? description;
  final int? quantity;
  final String? imageCover;
  final List<String>? images;
  final int? price;
  final double? ratingsAverage;
  final int? ratingsQuantity;
  final CategoryResponseEntity? category;
  final List<SubCategoryResponseEntity>? subcategory;

  WishlistDataEntity({
    this.sId,
    this.title,
    this.description,
    this.quantity,
    this.imageCover,
    this.images,
    this.price,
    this.ratingsAverage,
    this.ratingsQuantity,
    this.category,
    this.subcategory,
  });


}