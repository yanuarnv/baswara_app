import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class OnBoardingOneWidget extends StatelessWidget {
  const OnBoardingOneWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Expanded(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 40.0),
            child: Image.asset("assets/images/people_recycle.png"),
          ),
        ),
        Text(
          "Tukar Sampah",
          style: GoogleFonts.poppins(
              fontSize: 24,
              fontWeight: FontWeight.w600,
              color: const Color(0xff0F4B3A)),
        ),
        Text(
          "Jika Anda menukarkan sampah berarti\nAnda sudah menyelamatkan bumi",
          textAlign: TextAlign.center,
          style: GoogleFonts.poppins(
            fontSize: 16,
          ),
        )
      ],
    );
  }
}
