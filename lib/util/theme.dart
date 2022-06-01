import 'package:flutter/material.dart';

ThemeData light = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.light,
    primaryColor: const Color(0xFFF0F2F2),
    canvasColor: const Color(0xFFF0F2F2),
    scaffoldBackgroundColor: const Color(0xFFF0F2F2),
    colorScheme: ColorScheme.light(
        background: const Color(0xFFF0F2F2),
        primary: Color(0xFF456900),
        onPrimary: const Color(0xFFFFFFFF),       
        secondary: Color(0xFF608F06),),
    popupMenuTheme: const PopupMenuThemeData(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      color: Color(0xFFF5F7F7),
    ),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFFF0F2F2),
        color: Color(0xFFF0F2F2),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFF000000)),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFF000000))),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      surfaceTintColor: Color(0xFFFDFFFF),
      color: Color(0xFFFDFFFF),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFFFDFFFF),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    floatingActionButtonTheme: FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF959699),//0xFF456900
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    bottomAppBarColor: const Color(0xFFF0F2F2),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFF456900),),
      selectedLabelStyle: TextStyle(color: Color(0xFF456900),),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFFF0F2F2),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFFF0F2F2),
        indicatorColor: Color(0xFF456900),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFF050505),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFF050505), fontWeight: FontWeight.w500))),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFFF0F2F2)));

ThemeData dark = ThemeData(
    useMaterial3: true,
    textTheme: const TextTheme(
      titleMedium: TextStyle(fontWeight: FontWeight.w400),
    ),
    brightness: Brightness.dark,
    primaryColor: const Color(0xFF202020),
    scaffoldBackgroundColor: const Color(0xFF202020),
    canvasColor: const Color(0xFF202020),
    colorScheme: const ColorScheme.dark(
        background: Color(0xFF202020),
        primary: Color(0xFFA6D654),
        onPrimary: Color(0xFF213600),
        secondary: Color(0xFFA6D654)),
    appBarTheme: const AppBarTheme(
        surfaceTintColor: Color(0xFF202020),
        color: Color(0xFF202020),
        elevation: 0,
        iconTheme: IconThemeData(color: Color(0xFFFFFFFF)),
        titleTextStyle: TextStyle(
            fontSize: 22,
            fontWeight: FontWeight.w400,
            color: Color(0xFFFFFFFF))),
    cardTheme: const CardTheme(
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(12)),
      ),
      surfaceTintColor: Color(0xFF2D2D2D),
      color: Color(0xFF2D2D2D),
    ),
    dialogTheme: const DialogTheme(
      backgroundColor: Color(0xFF2D2D2D),
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(28)),
      ),
    ),
    bottomNavigationBarTheme: const BottomNavigationBarThemeData(
      selectedIconTheme: IconThemeData(color: Color(0xFFA6D654)),
      selectedLabelStyle: TextStyle(color: Color(0xFFA6D654)),
      showSelectedLabels: true,
      showUnselectedLabels: false,
      backgroundColor: Color(0xFF202020),
    ),
    floatingActionButtonTheme: const FloatingActionButtonThemeData(
      backgroundColor: Color(0xFF484848),//0xFFA6D654
      shape: RoundedRectangleBorder(
        borderRadius: BorderRadius.all(Radius.circular(16)),
      ),
    ),
    navigationBarTheme: NavigationBarThemeData(
        backgroundColor: const Color(0xFF202020),
        indicatorColor: const Color(0xFFA6D654),
        iconTheme: MaterialStateProperty.all(const IconThemeData(
          color: Color(0xFFEAEAEA),
        )),
        labelTextStyle: MaterialStateProperty.all(const TextStyle(
            color: Color(0xFFEAEAEA), fontWeight: FontWeight.w500))),

    bottomAppBarColor: const Color(0xFF202020),
    bottomSheetTheme:
    const BottomSheetThemeData(modalBackgroundColor: Color(0xFF202020)));
