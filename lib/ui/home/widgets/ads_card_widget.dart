import 'package:e_commerce_app/core/constants/app_assets.dart';
import 'package:flutter/material.dart';

class AdsCardWidget extends StatelessWidget{
  final String imagePath;

  AdsCardWidget({required this.imagePath});

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(20),
      child: Container(
        width: double.infinity,
        height: 200,
        child: Image.asset(imagePath ,
        fit: BoxFit.cover,
        ),
      ),
    );
  }
}