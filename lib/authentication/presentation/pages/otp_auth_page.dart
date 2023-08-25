import 'package:baswara_app/core/color_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';

class OtpAuthPage extends StatelessWidget {
  final String email;

  const OtpAuthPage({super.key, required this.email});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: SingleChildScrollView(
            child: Column(
              children: [
                const SizedBox(
                  height: 56,
                ),
                Text(
                  "Masukkan Kode OTP",
                  style: GoogleFonts.poppins(
                      fontSize: 24,
                      fontWeight: FontWeight.w600,
                      color: ColorValue.primary),
                ),
                Image.asset("assets/images/otp_image.png"),
                Text(
                  "Masukkan kode yang telah dikirimkan melalui E-mail Anda",
                  textAlign: TextAlign.center,
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                OtpTextField(
                  numberOfFields: 6,
                  borderColor: Color(0xFF512DA8),
                  //set to true to show as box or false to show as dash
                  showFieldAsBox: true,
                  //runs when a code is typed in
                  onCodeChanged: (String code) {
                    //handle validation or checks here
                  },
                  //runs when every textfield is filled
                  onSubmit: (String verificationCode) {}, // end onSubmit
                ),
                const SizedBox(
                  height: 14,
                ),
                RichText(
                  text: TextSpan(
                    text: "Tidak Menerima kode ? ",
                    style: GoogleFonts.poppins(
                        fontSize: 16,
                        fontWeight: FontWeight.w500,
                        color: const Color(0xff464646)),
                    children: [
                      TextSpan(
                        text: "Kirim Ulang",
                        style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: ColorValue.primary,
                        ),
                      )
                    ],
                  ),
                ),
                const SizedBox(
                  height: 17,
                ),
                ElevatedButton(
                    onPressed: () {}, child: const Text("Verifikasi"))
              ],
            ),
          ),
        ),
      ),
    );
  }
}
