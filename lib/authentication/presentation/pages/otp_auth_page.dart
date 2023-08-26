import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/authentication/presentation/manager/auth_bloc.dart';
import 'package:baswara_app/authentication/presentation/pages/forgot_password_page.dart';
import 'package:baswara_app/core/color_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_otp_text_field/flutter_otp_text_field.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/utility.dart';

class OtpAuthPage extends StatefulWidget {
  final String email;

  const OtpAuthPage({super.key, required this.email});

  @override
  State<OtpAuthPage> createState() => _OtpAuthPageState();
}

class _OtpAuthPageState extends State<OtpAuthPage> {
  final List<TextEditingController> _listOtp = [
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
    TextEditingController(),
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    for (var element in _listOtp) {
      element.dispose();
    }
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: BlocProvider(
        create: (context) =>
            AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is LoadingAuthState) {
              context.loaderOverlay.show();
            }
            if (state is SuccessCheckOtp) {
              context.loaderOverlay.hide();
              String otp = "";
              for (var element in _listOtp) {
                otp + element.text;
              }
              print("this is otp $otp");
              Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (_) => ForgotPasswordPage(
                          email: widget.email,
                          otp: otp,
                        )),
              );
            }
            if (state is FailureAuthState) {
              context.loaderOverlay.hide();
              Utility(context).showSnackbar(state.msg);
            }
          },
          builder: (context, state) {
            return SafeArea(
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
                        onSubmit: (String verificationCode) {
                          context
                              .read<AuthBloc>()
                              .add(PostOtpAuth(widget.email, verificationCode));
                        }, // end onSubmit
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
                    ],
                  ),
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
