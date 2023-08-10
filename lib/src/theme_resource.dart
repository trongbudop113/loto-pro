import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loto/src/color_resource.dart';

class ThemeResource{
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[600],
      brightness: Brightness.light,
      backgroundColor: Colors.grey[100],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      textTheme: TextTheme(
        bodyText1: GoogleFonts.pacifico(
          fontSize: 16,
          color: ColorResource.color_black_light,
          fontWeight: FontWeight.w500
        ),
        bodyText2: GoogleFonts.pacifico(
          fontSize: 16,
          color: ColorResource.color_white_light,
          fontWeight: FontWeight.w500
        ),
        caption: GoogleFonts.pacifico(
            fontSize: 18,
            color: ColorResource.color_black_light,
            fontWeight: FontWeight.bold
        ),
        headline1: GoogleFonts.pacifico(
            fontSize: 14,
            color: ColorResource.color_grey_light,
            fontWeight: FontWeight.w400
        )
      ),
      appBarTheme: AppBarTheme(
        color: Colors.white
      )
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: Colors.blue[600],
      brightness: Brightness.light,
      backgroundColor: Colors.grey[100],
      visualDensity: VisualDensity.adaptivePlatformDensity,
      appBarTheme: AppBarTheme(
        color: Colors.black
      )
    );
  }
}