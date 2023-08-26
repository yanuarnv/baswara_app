import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/authentication/presentation/pages/login_page.dart';
import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/utility.dart';
import '../manager/auth_bloc.dart';

class ForgotPasswordPage extends StatefulWidget {
  final String email;
  final String otp;

  const ForgotPasswordPage({super.key, required this.email, required this.otp});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final _password = TextEditingController();
  final _passwordConfirm = TextEditingController();
  final _form = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => AuthBloc(
          RepositoryProvider.of<AuthRepository>(context),
        ),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccesResetPassword) {
              context.loaderOverlay.hide();
              Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (_) => const LoginPage()),
                (route) => false,
              );
            }

            if (state is LoadingAuthState) {
              context.loaderOverlay.show();
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
                child: Form(
                  key: _form,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 74,
                      ),
                      Text(
                        "Atur Sandi",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: ColorValue.primary,
                        ),
                      ),
                      Text(
                        "Pastikan kata sandi yang Anda masukkan benar",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormWidget(
                        obsecure: true,
                        controller: _password,
                        label: "Sandi",
                        hint: "Masukkan Sandi",
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      CustomFormWidget(
                        obsecure: true,
                        controller: _passwordConfirm,
                        label: "Konfirmasi Sandi",
                        hint: "Masukkan Konfirmasi Sandi",
                        validation: (value) {
                          if (value == null || value.isEmpty) {
                            return 'Tolong Masukan Password';
                          }
                          if (value != _password.text) {
                            return 'Sandi harus sesuai';
                          }
                          return null;
                        },
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            context.read<AuthBloc>().add(
                                  ResetPassword(
                                    widget.email,
                                    widget.otp,
                                    _passwordConfirm.text,
                                  ),
                                );
                          }
                        },
                        child: const Text("Selanjutnya"),
                      )
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
