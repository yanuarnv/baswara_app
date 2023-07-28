import 'package:baswara_app/homeUser/presentation/pages/catalog_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_value.dart';

class HomeUserWidget extends StatelessWidget {
  const HomeUserWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        child: SingleChildScrollView(
          child: Column(
            children: [
              const SizedBox(
                height: 21,
              ),
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
              ),
              const SizedBox(
                height: 30,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "Katalog Bertawa",
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                      color: ColorValue.primary,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  GestureDetector(
                    onTap: () {
                      Navigator.push(
                          context,
                          MaterialPageRoute(
                              builder: (context) => const CatalogUserPage()));
                    },
                    child: Text(
                      "Selengkapnya",
                      style: GoogleFonts.poppins(
                        fontSize: 14,
                        color: ColorValue.primary,
                        fontWeight: FontWeight.w500,
                      ),
                    ),
                  )
                ],
              ),
              const SizedBox(
                height: 14,
              ),
              Text(
                "Gunakan uang untuk membeli kreasi produk dari sampah",
                style: GoogleFonts.poppins(
                    fontSize: 12, color: const Color(0xff909090)),
              ),
              const SizedBox(
                height: 13,
              ),
              GridView.builder(
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: 4,
                  shrinkWrap: true,
                  gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                      crossAxisSpacing: 20,
                      mainAxisSpacing: 14,
                      crossAxisCount: 2),
                  itemBuilder: (c, i) => Container(
                        padding: const EdgeInsets.all(10),
                        decoration: BoxDecoration(
                            color: Colors.white,
                            borderRadius: BorderRadius.circular(10),
                            boxShadow: [
                              BoxShadow(
                                color: Colors.grey.shade300,
                                offset: const Offset(0, 4),
                                blurRadius: 4,
                              )
                            ]),
                        child: Column(
                          children: [
                            Image.asset("assets/images/example_bag.png"),
                            const SizedBox(
                              height: 9,
                            ),
                            Text(
                              "Tempat Pensil",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w600,
                                  color: ColorValue.primary),
                            )
                          ],
                        ),
                      )),
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
