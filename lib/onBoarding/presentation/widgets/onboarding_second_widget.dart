import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
class OnBoardingSecondWidget extends StatelessWidget {
  const OnBoardingSecondWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset("assets/images/people_save_money.png"),
          ),
        ),
        Text(
          "Ubah Menjadi Uang",
          style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xff0F4B3A)),
        ),
        Text(
          "Anda mendapatkan saldo setiap penukaran sampah",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}