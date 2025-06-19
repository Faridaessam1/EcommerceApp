import 'package:flutter/material.dart';
import '../../../domain/entities/ProductsResponseEntity.dart';

class ProductViewModel {
  static String formatPrice(int? price, {String currency = 'EGP'}) {
    if (price == null) return '$currency 0';
    return '$currency ${price.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match m) => '${m[1]},',
    )}';
  }

  static String formatRating(double? rating) {
    if (rating == null) return '0.0';
    return rating.toStringAsFixed(1);
  }

  static String getProductImageUrl(ProductDataEntity product) {
    return product.imageCover ?? '';
  }

  static List<String> getProductImages(ProductDataEntity product) {
    return product.images ?? [];
  }

  static bool isProductInStock(ProductDataEntity product) {
    return (product.quantity ?? 0) > 0;
  }

  static String getStockStatus(ProductDataEntity product) {
    final quantity = product.quantity ?? 0;
    if (quantity == 0) return 'Out of Stock';
    if (quantity < 5) return 'Only $quantity left';
    return 'In Stock';
  }

  static Color getStockColor(ProductDataEntity product) {
    final quantity = product.quantity ?? 0;
    if (quantity == 0) return Colors.red;
    if (quantity < 5) return Colors.orange;
    return Colors.green;
  }

  static String getCategoryName(ProductDataEntity product) {
    return product.category?.name ?? 'Unknown Category';
  }

  static String getBrandName(ProductDataEntity product) {
    return product.brand?.name ?? 'Unknown Brand';
  }

  static String getSubcategoryNames(ProductDataEntity product) {
    if (product.subcategory == null || product.subcategory!.isEmpty) {
      return '';
    }
    return product.subcategory!.map((sub) => sub.name ?? '').join(', ');
  }

  static Widget buildRatingStars(double? rating) {
    final rate = rating ?? 0.0;
    return Row(
      mainAxisSize: MainAxisSize.min,
      children: List.generate(5, (index) {
        if (index < rate.floor()) {
          return const Icon(Icons.star, color: Colors.amber, size: 16);
        } else if (index < rate) {
          return const Icon(Icons.star_half, color: Colors.amber, size: 16);
        } else {
          return const Icon(Icons.star_border, color: Colors.grey, size: 16);
        }
      }),
    );
  }

  static String getShortDescription(String? description, {int maxLength = 50}) {
    if (description == null || description.isEmpty) return '';
    return description.length > maxLength
        ? '${description.substring(0, maxLength)}...'
        : description;
  }
}