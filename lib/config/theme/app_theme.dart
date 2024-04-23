import 'package:flutter/material.dart';
import 'package:sizer/sizer.dart';
// import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //  shared theme for any configuration on light theme & dark theme
  static final sharedTheme = ThemeData(
    // textTheme: GoogleFonts.ibmPlexSansTextTheme(),
    elevatedButtonTheme: ElevatedButtonThemeData(
      style: ElevatedButton.styleFrom(
        backgroundColor: const Color.fromARGB(255, 54, 33, 243),
        foregroundColor: Colors.white,
        minimumSize: Size(40.w, 60),
        maximumSize: Size(40.w, 60),
        shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(15),
        ),
      ),
    ),
    inputDecorationTheme: InputDecorationTheme(
      border: InputBorder.none,
      enabledBorder: InputBorder.none,
      focusedBorder: InputBorder.none,
    ),
  );
  static final lightTheme = sharedTheme.copyWith();
  static final darkTheme = sharedTheme.copyWith();
}
