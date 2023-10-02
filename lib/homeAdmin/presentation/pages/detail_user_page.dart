import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/core/utility.dart';
import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class DetailUserPage extends StatelessWidget {
  final Data model;

  const DetailUserPage({super.key, required this.model});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorValue.primary,
        centerTitle: true,
        title: Text(
          "Detail Profil Pengguna",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 26,
            ),
            Center(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(90),
                child: model.imageUrl.isEmpty
                    ? Utility(context).emptyProfileImg(model.name)
                    : Image.network(model.imageUrl,
                        fit: BoxFit.cover,
                        width: 180,
                        height: 180,
                        errorBuilder: (c, __, _) =>
                            Utility(context).emptyProfileImg(model.name)),
              ),
            ),
            const SizedBox(
              height: 40,
            ),
            Container(
              padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
              margin: const EdgeInsets.only(bottom: 39),
              decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(10),
                  color: Colors.white,
                  boxShadow: const [
                    BoxShadow(
                        color: Colors.grey,
                        blurRadius: 10,
                        offset: Offset(0, 2)),
                  ]),
              child: Row(
                children: [
                  SvgPicture.asset(
                    "assets/icons/icon_wallet.svg",
                    width: 45,
                    height: 45,
                  ),
                  const SizedBox(
                    width: 9,
                  ),
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        "Saldo",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.black),
                      ),
                      Text(
                        "Rp ${model.savings}",
                        style: GoogleFonts.poppins(
                          fontSize: 20,
                          fontWeight: FontWeight.w600,
                          color: ColorValue.primary,
                        ),
                      )
                    ],
                  )
                ],
              ),
            ),
            Text(
              "Nama",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              model.name,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455A64),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "No. HP",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              model.phone,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455A64),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Email",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              model.email,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455A64),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rt",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              model.rt,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455A64),
              ),
            ),
            const SizedBox(
              height: 10,
            ),
            Text(
              "Rw",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: Colors.black,
              ),
            ),
            Text(
              model.rw,
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455A64),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
