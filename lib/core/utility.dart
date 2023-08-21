import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class Utility {
  final BuildContext context;

  Utility(this.context);

  void showSnackbar(String message, {Color? color}) {
    ScaffoldMessenger.of(context).showSnackBar(SnackBar(
      content: Text(message),
      backgroundColor: color ?? Colors.red,
    ));
  }

  Widget emptyProfileImg(String inisial) {
    return Container(
      width: 180,
      height: 180,
      decoration: const BoxDecoration(
        shape: BoxShape.circle,
        color: Colors.grey,
      ),
      child: Center(
        child: Text(
          inisial.substring(0, 1).toUpperCase(),
          style: GoogleFonts.inter(color: Colors.white, fontSize: 40.sp),
        ),
      ),
    );
  }
}
