import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/jenis_sampah_page.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/profile_users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DashBoardAdminWidget extends StatefulWidget {
  const DashBoardAdminWidget({super.key});

  @override
  State<DashBoardAdminWidget> createState() => _DashBoardAdminWidgetState();
}

class _DashBoardAdminWidgetState extends State<DashBoardAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: 21,
              ),
              Text(
                "Selamat Datang, Admin!",
                style: GoogleFonts.poppins(
                  fontSize: 20,
                  fontWeight: FontWeight.w600,
                  color: ColorValue.primary,
                ),
              ),
              Text(
                "Tetap pantau sampah yang masuk agar sampah dapat terdaur ulang dengan baik",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 16,
              ),
              ClipRRect(
                borderRadius: BorderRadius.circular(4),
                child: Container(
                  padding: const EdgeInsets.all(10),
                  decoration: const BoxDecoration(
                      color: Colors.white,
                      border: Border(
                          left:
                              BorderSide(color: ColorValue.primary, width: 3))),
                  child: Row(
                    children: [
                      SvgPicture.asset("assets/icons/icon_shoping_circle.svg"),
                      const SizedBox(
                        width: 21,
                      ),
                      Column(
                        mainAxisSize: MainAxisSize.min,
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            "Penjualan (Rp)",
                            style: GoogleFonts.poppins(
                              fontSize: 20,
                              fontWeight: FontWeight.w500,
                              color: ColorValue.primary,
                            ),
                          ),
                          Text(
                            "Rp. 2000.000",
                            style: GoogleFonts.poppins(
                              fontSize: 24,
                              fontWeight: FontWeight.w600,
                              color: Colors.black,
                            ),
                          )
                        ],
                      )
                    ],
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const ProfileUsersPage()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(
                                color: ColorValue.primary, width: 3))),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/icon_people.svg"),
                        const SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Pengguna Baswara",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: ColorValue.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 18,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const JenisSampahPage()));
                },
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(4),
                  child: Container(
                    padding: const EdgeInsets.all(10),
                    decoration: const BoxDecoration(
                        color: Colors.white,
                        border: Border(
                            left: BorderSide(
                                color: ColorValue.primary, width: 3))),
                    child: Row(
                      children: [
                        SvgPicture.asset("assets/icons/icon_trash_grey.svg"),
                        const SizedBox(
                          width: 21,
                        ),
                        Text(
                          "Jenis Sampah ",
                          style: GoogleFonts.poppins(
                            fontSize: 20,
                            fontWeight: FontWeight.w500,
                            color: ColorValue.primary,
                          ),
                        )
                      ],
                    ),
                  ),
                ),
              ),
              const SizedBox(
                height: 26,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
