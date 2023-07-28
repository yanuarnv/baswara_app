import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_value.dart';
class CatalogUserPage extends StatelessWidget {
  const CatalogUserPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorValue.primary,
        title: Text(
          "Katalog Baswara",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: GridView.builder(
          itemCount: 12,
          shrinkWrap: true,
          padding: const EdgeInsets.symmetric(horizontal: 16,vertical: 30),
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
    );
  }
}
