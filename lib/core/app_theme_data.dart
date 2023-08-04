import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import 'color_value.dart';

class AppThemeData {
  static ThemeData getTheme(BuildContext context) {
    const Color primaryColor = ColorValue.primary;
    final Map<int, Color> primaryColorMap = {
      50: primaryColor,
      100: primaryColor,
      200: primaryColor,
      300: primaryColor,
      400: primaryColor,
      500: primaryColor,
      600: primaryColor,
      700: primaryColor,
      800: primaryColor,
      900: primaryColor,
    };
    final MaterialColor primaryMaterialColor =
        MaterialColor(primaryColor.value, primaryColorMap);

    return ThemeData(
        primaryColor: primaryColor,
        primarySwatch: primaryMaterialColor,
        scaffoldBackgroundColor:  const Color(0xffF5F5F5),
        canvasColor: const Color(0xffF5F5F5),
        brightness: Brightness.light,
        iconTheme: IconThemeData(size: 6.w),
        bottomNavigationBarTheme: BottomNavigationBarThemeData(
            selectedLabelStyle:
                GoogleFonts.poppins(fontSize: 16, color: ColorValue.primary),
            unselectedLabelStyle: GoogleFonts.poppins(
              fontSize: 16,
            ),
            selectedIconTheme: const IconThemeData(color: ColorValue.primary),
            unselectedIconTheme: const IconThemeData(color: Colors.black)),
        elevatedButtonTheme: ElevatedButtonThemeData(
            style: ElevatedButton.styleFrom(
                minimumSize: const Size(double.infinity, 45),
                foregroundColor: Colors.white,
                shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(20.sp)),
                textStyle: TextStyle(
                  color: Colors.white,
                  fontWeight: FontWeight.w600,
                  fontSize: 8.sp,
                ))),
        tabBarTheme: TabBarTheme(
          labelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 8.sp,
          ),
          unselectedLabelStyle: GoogleFonts.poppins(
            fontWeight: FontWeight.w500,
            fontSize: 8.sp,
          ),
        ),
        appBarTheme: AppBarTheme(
          iconTheme: IconThemeData(color: Colors.white, size: 14.sp),
          elevation: 0,
          backgroundColor: Colors.white,
          titleTextStyle: GoogleFonts.urbanist(
            fontWeight: FontWeight.w700,
            fontSize: 20,
            color: const Color(0xff0B090A),
          ),
          toolbarTextStyle:
              GoogleFonts.poppins(fontWeight: FontWeight.w700, fontSize: 7.sp),
        ),
        textTheme: GoogleFonts.podkovaTextTheme());
  }
}
