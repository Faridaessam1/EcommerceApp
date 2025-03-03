import 'package:cached_network_image/cached_network_image.dart';
import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:e_commerce_app/core/constants/app_styles.dart';
import 'package:flutter/material.dart';

import '../../../core/constants/app_colors.dart';
import '../../../domain/entities/category_response_entity.dart';

class CategoriesCardWidget extends StatelessWidget {
  CategoryDataEntity item;

  CategoriesCardWidget({super.key, required this.item});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          flex: 8,
          child: CachedNetworkImage(
            imageUrl:item.image??"",
            imageBuilder: (context, imageProvider) => Container(
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                image: DecorationImage(
                  image: imageProvider,
                  fit: BoxFit.cover,
                ),
              ),
            ),
            placeholder: (context, url) => const Center(
              child: CircularProgressIndicator(
                color: AppColors.primaryColor,
              ),
            ),
            errorWidget: (context, url, error) => const Center(
              child: Icon(
                Icons.error,
                color: Colors.red,
              ),
            ),
          ),
        ),
        SizedBox(height: 5,),
        Expanded(
          flex: 4 ,
          child: Text(
           item.name ?? "",
            style: AppStyles.W400Blue14,
          textAlign: TextAlign.center,
          ),
        )
      ],
    );
  }
}
