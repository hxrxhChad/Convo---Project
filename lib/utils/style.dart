import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:google_fonts/google_fonts.dart';

import 'index.dart';

class Style {
  static const _pageTransitionTheme = PageTransitionsTheme(builders: {
    TargetPlatform.android: CupertinoPageTransitionsBuilder(),
    TargetPlatform.iOS: CupertinoPageTransitionsBuilder(),
  });

  static final ThemeData light = ThemeData(
      brightness: Brightness.light,
      colorScheme: const ColorScheme.light().copyWith(
        primary: lightPrimaryColor,
      ),
      primaryColor: lightPrimaryColor,
      pageTransitionsTheme: _pageTransitionTheme,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.light().textTheme));

  static final ThemeData dark = ThemeData(
      brightness: Brightness.dark,
      colorScheme: const ColorScheme.dark().copyWith(
        primary: darkPrimaryColor,
      ),
      primaryColor: darkPrimaryColor,
      pageTransitionsTheme: _pageTransitionTheme,
      textTheme: GoogleFonts.poppinsTextTheme(ThemeData.dark().textTheme));

  void systemOverlay(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
      statusBarColor: Colors.transparent,
      systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
    ));
  }

  void lightOverlay(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).scaffoldBackgroundColor,
        statusBarIconBrightness: Brightness.dark,
        systemNavigationBarIconBrightness: Brightness.dark));
  }

  void darkOverlay(BuildContext context) {
    SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle(
        statusBarColor: Colors.transparent,
        systemNavigationBarColor: Theme.of(context).shadowColor,
        statusBarIconBrightness: Brightness.light,
        systemNavigationBarIconBrightness: Brightness.light));
  }
}
