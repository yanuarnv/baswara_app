import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class ProfileAdminWidget extends StatelessWidget {
  const ProfileAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(
              height: 26,
            ),
            Center(
              child: Container(
                width: 180,
                height: 180,
                decoration: BoxDecoration(
                    color: Colors.grey,
                    borderRadius: BorderRadius.circular(90)),
                child: const Icon(Icons.person, size: 60),
              ),
            ),
            const SizedBox(
              height: 40,
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
              "Jodan will smith",
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
              "0882003251891",
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
              "jodansmith@imagine.com",
              style: GoogleFonts.poppins(
                fontSize: 16,
                fontWeight: FontWeight.w500,
                color: const Color(0xff455A64),
              ),
            ),
            const SizedBox(
              height: 80,
            ),
            ElevatedButton(
                onPressed: () {},
                child: Text(
                  "Edit",
                  style: GoogleFonts.poppins(
                    fontWeight: FontWeight.w500,
                    fontSize: 16,
                  ),
                ))
          ],
        ),
      ),
    );
  }
}
