// ProductBrandDM
import '../../../domain/entities/ProductsResponseEntity.dart';

class ProductBrandDM extends ProductBrandResponseEntity {
  ProductBrandDM({
    String? id,
    String? name,
    String? slug,
    String? image,
  }) : super(
    id: id,
    name: name,
    slug: slug,
    image: image,
  );

  factory ProductBrandDM.fromJson(Map<String, dynamic> json) {
    return ProductBrandDM(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
  };
}

// ProductCategoryDM
class ProductCategoryDM extends ProductCategoryResponseEntity {
  ProductCategoryDM({
    String? id,
    String? name,
    String? slug,
    String? image,
  }) : super(
    id: id,
    name: name,
    slug: slug,
    image: image,
  );

  factory ProductCategoryDM.fromJson(Map<String, dynamic> json) {
    return ProductCategoryDM(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      slug: json['slug'],
      image: json['image'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'image': image,
  };
}

// ProductSubCategoryDM
class ProductSubCategoryDM extends ProductSubCategoryResponseEntity {
  ProductSubCategoryDM({
    String? id,
    String? name,
    String? slug,
    String? category,
  }) : super(
    id: id,
    name: name,
    slug: slug,
    category: category,
  );

  factory ProductSubCategoryDM.fromJson(Map<String, dynamic> json) {
    return ProductSubCategoryDM(
      id: json['_id'] ?? json['id'],
      name: json['name'],
      slug: json['slug'],
      category: json['category'],
    );
  }

  Map<String, dynamic> toJson() => {
    'id': id,
    'name': name,
    'slug': slug,
    'category': category,
  };
}

// ProductDataDM
class ProductDataDM extends ProductDataEntity {
  ProductDataDM({
    int? sold,
    List<String>? images,
    List<ProductSubCategoryResponseEntity>? subcategory,
    int? ratingsQuantity,
    String? id,
    String? title,
    String? slug,
    String? description,
    int? quantity,
    int? price,
    String? imageCover,
    ProductCategoryResponseEntity? category,
    ProductBrandResponseEntity? brand,
    double? ratingsAverage,
    String? createdAt,
    String? updatedAt,
    int? v,
    List<dynamic>? reviews,
  }) : super(
    sold: sold,
    images: images,
    subcategory: subcategory,
    ratingsQuantity: ratingsQuantity,
    id: id,
    title: title,
    slug: slug,
    description: description,
    quantity: quantity,
    price: price,
    imageCover: imageCover,
    category: category,
    brand: brand,
    ratingsAverage: ratingsAverage,
    createdAt: createdAt,
    updatedAt: updatedAt,
    v: v,
    reviews: reviews,
  );

  factory ProductDataDM.fromJson(Map<String, dynamic> json) {
    return ProductDataDM(
      sold: json['sold'],
      images: (json['images'] as List?)?.map((e) => e.toString()).toList(),
      subcategory: (json['subcategory'] as List?)?.map((e) => ProductSubCategoryDM.fromJson(e)).toList(),
      ratingsQuantity: json['ratingsQuantity'],
      id: json['_id'] ?? json['id'],
      title: json['title'],
      slug: json['slug'],
      description: json['description'],
      quantity: json['quantity'],
      price: json['price'],
      imageCover: json['imageCover'],
      category: json['category'] != null ? ProductCategoryDM.fromJson(json['category']) : null,
      brand: json['brand'] != null ? ProductBrandDM.fromJson(json['brand']) : null,
      ratingsAverage: (json['ratingsAverage'] as num?)?.toDouble(),
      createdAt: json['createdAt'],
      updatedAt: json['updatedAt'],
      v: json['__v'],
      reviews: json['reviews'] ?? [],
    );
  }

  Map<String, dynamic> toJson() => {
    'sold': sold,
    'images': images,
    'subcategory': subcategory?.map((e) => (e as ProductSubCategoryDM).toJson()).toList(),
    'ratingsQuantity': ratingsQuantity,
    'id': id,
    'title': title,
    'slug': slug,
    'description': description,
    'quantity': quantity,
    'price': price,
    'imageCover': imageCover,
    'category': (category as ProductCategoryDM?)?.toJson(),
    'brand': (brand as ProductBrandDM?)?.toJson(),
    'ratingsAverage': ratingsAverage,
    'createdAt': createdAt,
    'updatedAt': updatedAt,
    '__v': v,
    'reviews': reviews,
  };
}

// ProductsResponseDM
class ProductsResponseDM extends ProductsResponseEntity {
  ProductsResponseDM({
    List<ProductDataEntity>? data,
  }) : super(data: data);

  factory ProductsResponseDM.fromJson(Map<String, dynamic> json) {
    return ProductsResponseDM(
      data: (json['data'] as List?)?.map((e) => ProductDataDM.fromJson(e)).toList(),
    );
  }

  Map<String, dynamic> toJson() => {
    'data': data?.map((e) => (e as ProductDataDM).toJson()).toList(),
  };
}
