import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeUser/presentation/pages/home_user_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/custom_form_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 16.0),
          child: Form(
            key: _formKey,
            child: SingleChildScrollView(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.center,
                children: [
                  SizedBox(
                    height: 10.h,
                  ),
                  Text(
                    "Baswara",
                    style: GoogleFonts.poppins(
                        fontWeight: FontWeight.w600,
                        fontSize: 24,
                        color: const Color(0xff27714E)),
                  ),
                  Text(
                    "Selamat datang, silakan masukkan Nama, No.\nTelepon, e-mail, dan sandi",
                    textAlign: TextAlign.center,
                    style: GoogleFonts.poppins(
                      fontSize: 15,
                    ),
                  ),
                  const SizedBox(
                    height: 29,
                  ),
                  CustomFormWidget(
                    obsecure: false,
                    hint: "Masukkan Nama Lengkap",
                    label: "Nama Lengkap",
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomFormWidget(
                    obsecure: false,
                    hint: "Masukkan Nomor Telepon",
                    label: "Nomor Telepon",
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomFormWidget(
                    obsecure: false,
                    hint: "Masukkan E-mail",
                    label: "E-mail",
                  ),
                  const SizedBox(
                    height: 14,
                  ),
                  CustomFormWidget(
                    obsecure: true,
                    hint: "Masukkan Password",
                    label: "Password",
                  ),
                  const SizedBox(
                    height: 20,
                  ),
                  const SizedBox(
                    height: 15,
                  ),
                  ElevatedButton(
                    onPressed: () {
                      Navigator.pushAndRemoveUntil(context, MaterialPageRoute(
                          builder: (context) => HomeUserPage()), (route) => false);
                    },
                    child: Text(
                      "Daftar",
                      style: GoogleFonts.poppins(
                        fontSize: 16,
                      ),
                    ),
                  ),
                  const SizedBox(
                    height: 25,
                  ),
                  GestureDetector(
                    onTap: (){
                      Navigator.pop(context);
                    },
                    child: RichText(
                      text: TextSpan(
                        text: 'Sudah mempunyai akun? ',
                        style: GoogleFonts.poppins(color: Colors.black),
                        children: <TextSpan>[
                          TextSpan(
                              text: 'Masuk',
                              style: GoogleFonts.poppins(
                                color: ColorValue.primary,
                              )),
                        ],
                      ),
                    ),
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
