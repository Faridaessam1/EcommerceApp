import 'dart:ui';
import 'package:flutter/src/painting/text_style.dart';
import 'package:google_fonts/google_fonts.dart';

import 'app_colors.dart';

abstract class AppStyles{
  static TextStyle W600Whithe24 = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w600,
    fontSize: 24,

  );
  static TextStyle W300White16 = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w300,
    fontSize: 16,

  );
  static TextStyle W300White18 = GoogleFonts.poppins(
    color: AppColors.grayColor,
    fontWeight: FontWeight.w300,
    fontSize: 18,

  );
  static TextStyle W500White18 = GoogleFonts.poppins(
    color: AppColors.whiteColor,
    fontWeight: FontWeight.w500,
    fontSize: 18,

  );

}