import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/authentication/presentation/pages/register_page.dart';
import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/core/utility.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/home_admin_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/custom_form_widget.dart';
import '../manager/auth_bloc.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {
  final _formKey = GlobalKey<FormState>();
  final TextEditingController _email = TextEditingController();
  final TextEditingController _password = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
        child: BlocConsumer<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccessAuthState) {
              context.loaderOverlay.hide();
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) =>
                      const HomeAdminPage(),
                ),
              );
            }
            if(state is LoadingAuthState){
              context.loaderOverlay.show();
            }
            if(state is FailureAuthState){
              context.loaderOverlay.hide();
              Utility(context).showSnackbar(state.msg);
            }
          },
          builder: (context, state) {
            return SafeArea(
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 16.0),
                child: SingleChildScrollView(
                  child: Form(
                    key: _formKey,
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
                          "Selamat datang kembali, silakan\nmasukkan email dan password",
                          textAlign: TextAlign.center,
                          style: GoogleFonts.poppins(
                            fontSize: 15,
                          ),
                        ),
                        const SizedBox(
                          height: 29,
                        ),
                        CustomFormWidget(
                          controller: _email,
                          obsecure: false,
                          hint: "Masukkan E-mail",
                          label: "E-mail",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomFormWidget(
                          controller: _password,
                          obsecure: true,
                          hint: "Masukkan Password",
                          label: "Password",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        Align(
                          alignment: Alignment.topRight,
                          child: Text(
                            "Lupa kata sandi?",
                            style: GoogleFonts.poppins(fontSize: 16),
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context
                                  .read<AuthBloc>()
                                  .add(LoginAuth(_email.text, _password.text));
                            }
                          },
                          child: Text(
                            "Masuk",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 25,
                        ),
                        GestureDetector(
                          onTap: () {
                            Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => const RegisterPage(),
                              ),
                            );
                          },
                          child: RichText(
                            text: TextSpan(
                              text: 'Tidak mempunyai akun? ',
                              style: GoogleFonts.poppins(color: Colors.black),
                              children: <TextSpan>[
                                TextSpan(
                                    text: 'Daftar',
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
            );
          },
        ),
      ),
    );
  }
}
