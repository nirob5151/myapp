import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

const Color primaryColor = Color(0xFF2E7D32);
const Color secondaryColor = Color(0xFFFFC107);

final TextTheme appTextTheme = TextTheme(
  displayLarge: GoogleFonts.merriweather(fontSize: 57, fontWeight: FontWeight.bold),
  titleLarge: GoogleFonts.oswald(fontSize: 22, fontWeight: FontWeight.w500),
  bodyMedium: GoogleFonts.roboto(fontSize: 14),
);

final ThemeData lightTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.light,
    secondary: secondaryColor,
  ),
  textTheme: appTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: primaryColor,
    foregroundColor: Colors.white,
    titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.white,
      backgroundColor: primaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
);

final ThemeData darkTheme = ThemeData(
  useMaterial3: true,
  colorScheme: ColorScheme.fromSeed(
    seedColor: primaryColor,
    brightness: Brightness.dark,
    secondary: secondaryColor,
  ),
  textTheme: appTextTheme,
  appBarTheme: AppBarTheme(
    backgroundColor: Colors.grey[900],
    foregroundColor: Colors.white,
    titleTextStyle: GoogleFonts.oswald(fontSize: 24, fontWeight: FontWeight.bold),
  ),
  elevatedButtonTheme: ElevatedButtonThemeData(
    style: ElevatedButton.styleFrom(
      foregroundColor: Colors.black,
      backgroundColor: secondaryColor,
      shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(8)),
      padding: const EdgeInsets.symmetric(horizontal: 24, vertical: 12),
      textStyle: GoogleFonts.roboto(fontSize: 16, fontWeight: FontWeight.w500),
    ),
  ),
);
