import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/authentication/presentation/pages/otp_auth_page.dart';
import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/utility.dart';
import '../manager/auth_bloc.dart';

class ForgotEmailPage extends StatefulWidget {
  const ForgotEmailPage({super.key});

  @override
  State<ForgotEmailPage> createState() => _ForgotEmailPageState();
}

class _ForgotEmailPageState extends State<ForgotEmailPage> {
  final _email = TextEditingController();
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
            if (state is SuccesCheckEmail) {
              context.loaderOverlay.hide();
              Navigator.push(
                  context,
                  MaterialPageRoute(
                      builder: (_) => OtpAuthPage(
                            email: _email.text,
                          )));
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
                        "Masukkan E-mail",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w600,
                          fontSize: 24,
                          color: ColorValue.primary,
                        ),
                      ),
                      Text(
                        "Masukkan E-mail untuk memperbarui kata sandi",
                        style: GoogleFonts.poppins(
                          fontWeight: FontWeight.w400,
                          fontSize: 16,
                        ),
                      ),
                      const SizedBox(
                        height: 20,
                      ),
                      CustomFormWidget(
                        obsecure: false,
                        controller: _email,
                        label: "E-mail",
                        hint: "Masukkan Alamat E-mail",
                      ),
                      const SizedBox(
                        height: 29,
                      ),
                      ElevatedButton(
                        onPressed: () {
                          if (_form.currentState!.validate()) {
                            context
                                .read<AuthBloc>()
                                .add(PostOtpEmailAuth(_email.text));
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
