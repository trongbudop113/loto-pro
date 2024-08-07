import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loto/src/color_resource.dart';

class ThemeResource{
  static ThemeData lightTheme() {
    return ThemeData(
      primarySwatch: Colors.blue,
      primaryColor: ColorResource.color_background_light,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
      cardColor: ColorResource.color_main_light,
        bottomSheetTheme: const BottomSheetThemeData(
            backgroundColor: ColorResource.color_white_light
        ),
      textTheme: TextTheme(
        bodyMedium: GoogleFonts.josefinSans(
          fontSize: 16,
          color: ColorResource.color_black_light,
          fontWeight: FontWeight.w500,
          height: 1
        ),
        bodyLarge: GoogleFonts.josefinSans(
          fontSize: 16,
          color: ColorResource.color_white_light,
          fontWeight: FontWeight.w500,
            height: 1
        ),
        labelLarge: GoogleFonts.josefinSans(
            fontSize: 18,
            color: ColorResource.color_black_light,
            fontWeight: FontWeight.bold,
            height: 1
        ),
        bodySmall: GoogleFonts.josefinSans(
            fontSize: 14,
            color: ColorResource.color_grey_light,
            fontWeight: FontWeight.w400,
            height: 1
        )
      ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
      appBarTheme: AppBarTheme(
        color: ColorResource.color_main_light,
        iconTheme: const IconThemeData(
          color: ColorResource.color_white_light,
        ),
        centerTitle: true,
        titleTextStyle: GoogleFonts.pacifico(
            fontSize: 18,
            color: ColorResource.color_white_light,
            fontWeight: FontWeight.bold
        ),
        actionsIconTheme: const IconThemeData(
          color: ColorResource.color_white_light
        )
      ),
      navigationBarTheme: const NavigationBarThemeData(
        backgroundColor: Colors.transparent
      )
    );
  }

  static ThemeData darkTheme() {
    return ThemeData(
        primarySwatch: Colors.blue,
        primaryColor: ColorResource.color_background_dark,
        brightness: Brightness.dark,
        visualDensity: VisualDensity.adaptivePlatformDensity,
        cardColor: ColorResource.color_main_dark,
        bottomSheetTheme: const BottomSheetThemeData(
          backgroundColor: ColorResource.color_white_dark
        ),
        textTheme: TextTheme(
            bodyMedium: GoogleFonts.pacifico(
                fontSize: 16,
                color: ColorResource.color_black_dark,
                fontWeight: FontWeight.w500,
                height: 1
            ),
            bodyLarge: GoogleFonts.pacifico(
                fontSize: 16,
                color: ColorResource.color_white_dark,
                fontWeight: FontWeight.w500,
                height: 1
            ),
            labelLarge: GoogleFonts.pacifico(
                fontSize: 18,
                color: ColorResource.color_black_dark,
                fontWeight: FontWeight.bold,
                height: 1
            ),
            bodySmall: GoogleFonts.pacifico(
                fontSize: 14,
                color: ColorResource.color_grey_dark,
                fontWeight: FontWeight.w400,
                height: 1
            )
        ),
        pageTransitionsTheme: const PageTransitionsTheme(
          builders: <TargetPlatform, PageTransitionsBuilder>{
            TargetPlatform.android: ZoomPageTransitionsBuilder(),
          },
        ),
        appBarTheme: AppBarTheme(
            color: ColorResource.color_main_dark,
            iconTheme: const IconThemeData(
              color: ColorResource.color_white_dark,
            ),
            centerTitle: true,
            titleTextStyle: GoogleFonts.pacifico(
                fontSize: 18,
                color: ColorResource.color_white_dark,
                fontWeight: FontWeight.bold
            ),
            actionsIconTheme: IconThemeData(
                color: ColorResource.color_white_dark
            )
        )
    );
  }
}