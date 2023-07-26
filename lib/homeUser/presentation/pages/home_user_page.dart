import 'package:baswara_app/core/color_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class HomeUserPage extends StatelessWidget {
  const HomeUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xffF5F5F5),
      appBar: AppBar(
        backgroundColor: ColorValue.primary,
        title: Text(
          "Baswara",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: SvgPicture.asset("assets/icons/icon_notif_appbar.svg"),
          )
        ],
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          children: [
            const SizedBox(height: 21,),
            Container(
              padding: const EdgeInsets.all(10),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(10),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Image.asset("assets/images/dashboard_people.png"),
                  const SizedBox(
                    height: 15,
                  ),
                  Text(
                    "Lihat Total Sampahmu",
                    style: GoogleFonts.poppins(
                      fontSize: 20,
                      color: ColorValue.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Text(
                    "Anda bisa melihat total sampah dan uang yang Anda dapatkan.",
                    style: GoogleFonts.poppins(
                      fontSize: 12,
                      color: const Color(0xff909090),
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
