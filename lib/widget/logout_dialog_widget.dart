import 'package:baswara_app/core/local_auth_storage.dart';
import 'package:baswara_app/onBoarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class LogoutDialogWidget extends StatelessWidget {
  const LogoutDialogWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/icon_logout_red.svg"),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Keluar Aplikasi",
            style: GoogleFonts.montserrat(
                fontWeight: FontWeight.w700, fontSize: 20),
          ),
          const SizedBox(
            height: 30,
          ),
          Text(
            "Apakah Anda yakin ingin keluar aplikasi?",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
              fontWeight: FontWeight.w500,
              fontSize: 14,
            ),
          ),
          const SizedBox(
            height: 27,
          ),
          Row(
            children: [
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffECECEC)),
                  onPressed: () {
                    Navigator.pop(context);
                  },
                  child: Text(
                    "Kembali",
                    style: GoogleFonts.poppins(
                      fontWeight: FontWeight.w500,
                      fontSize: 16,
                      color: const Color(0xff909090),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 20,
              ),
              Expanded(
                child: ElevatedButton(
                  style: ElevatedButton.styleFrom(
                      backgroundColor: const Color(0xffC72D2D)),
                  onPressed: () async {
                    await LocalAuthStorage().delete();
                    Navigator.pushReplacement(context, MaterialPageRoute(
                        builder: (context) => OnBoardingPage()));
                  },
                  child: Text(
                    "Yakin",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w500, fontSize: 16),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
