import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:rent_hub_flutter_project/src/constants/colors.dart';
import 'package:rent_hub_flutter_project/src/constants/sizes.dart';

class AppTheme {
  AppTheme._();
  static ThemeData lightTheme = ThemeData(
    cardColor: Colors.grey.shade300,
    brightness: Brightness.light,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(fontSize: 28.0,fontWeight: FontWeight.bold,color: tDarkColor),
      displayMedium: GoogleFonts.montserrat(fontSize: 24.0,fontWeight: FontWeight.w700,color: tDarkColor),
      displaySmall: GoogleFonts.poppins(fontSize: 24.0,fontWeight: FontWeight.w700,color: tDarkColor),
      headlineMedium: GoogleFonts.poppins(fontSize: 16.0,fontWeight: FontWeight.w600,color: tDarkColor),
      titleLarge: GoogleFonts.poppins(fontSize: 14.0,fontWeight: FontWeight.w600,color: tDarkColor),
      bodyLarge: GoogleFonts.poppins(fontSize: 14.0,fontWeight: FontWeight.normal,color: tDarkColor),
      bodyMedium: GoogleFonts.poppins(fontSize: 14.0,fontWeight: FontWeight.normal,color: tDarkColor),
    ),
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: tWhiteColor,
        backgroundColor: tSecondaryColor,
        side: const BorderSide(color: tSecondaryColor),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: tSecondaryColor,
        backgroundColor: tWhiteColor,
        side: const BorderSide(color: tSecondaryColor),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5.0)),
      ),
    ),
  );

  static ThemeData darkTheme = ThemeData(
    cardColor: Colors.black54,
    brightness: Brightness.dark,
    textTheme: TextTheme(
      displayLarge: GoogleFonts.montserrat(fontSize: 28.0,fontWeight: FontWeight.bold,color: tWhiteColor),
      displayMedium: GoogleFonts.montserrat(fontSize: 24.0,fontWeight: FontWeight.w700,color: tWhiteColor),
      displaySmall: GoogleFonts.poppins(fontSize: 24.0,fontWeight: FontWeight.w700,color: tWhiteColor),
      headlineMedium: GoogleFonts.poppins(fontSize: 16.0,fontWeight: FontWeight.w600,color: tWhiteColor),
      titleLarge: GoogleFonts.poppins(fontSize: 14.0,fontWeight: FontWeight.w600,color: tWhiteColor),
      bodyLarge: GoogleFonts.poppins(fontSize: 14.0,fontWeight: FontWeight.normal,color: tWhiteColor),
      bodyMedium: GoogleFonts.poppins(fontSize: 14.0,fontWeight: FontWeight.normal,color: tWhiteColor),
    ),
    appBarTheme: AppBarTheme(),
    floatingActionButtonTheme: FloatingActionButtonThemeData(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        elevation: 0,
        foregroundColor: tSecondaryColor,
        backgroundColor: tWhiteColor,
        side: const BorderSide(color: tWhiteColor),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    ),
    outlinedButtonTheme: OutlinedButtonThemeData(
      style: OutlinedButton.styleFrom(
        elevation: 0,
        foregroundColor: tWhiteColor,
        backgroundColor: tSecondaryColor,
        side: const BorderSide(color: tWhiteColor),
        padding: const EdgeInsets.symmetric(vertical: tButtonHeight),
        shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(5)),
      ),
    ),
  );
}
