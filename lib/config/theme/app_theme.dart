import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class AppTheme {
  //  shared theme for any configuration on light theme & dark theme
  static final sharedTheme = ThemeData(
    textTheme: GoogleFonts.ibmPlexSansTextTheme(),
  );
  static final lightTheme = sharedTheme.copyWith(
    
  );
  static final darkTheme = sharedTheme.copyWith();
}
