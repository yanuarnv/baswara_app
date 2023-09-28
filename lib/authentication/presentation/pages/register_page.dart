import 'dart:io';

import 'package:baswara_app/authentication/domain/repositories/auth_repository.dart';
import 'package:baswara_app/authentication/presentation/manager/auth_bloc.dart';
import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/core/utility.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/home_admin_page.dart';
import 'package:baswara_app/homeUser/presentation/pages/home_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../widget/custom_form_widget.dart';

class RegisterPage extends StatefulWidget {
  const RegisterPage({super.key});

  @override
  State<RegisterPage> createState() => _RegisterPageState();
}

class _RegisterPageState extends State<RegisterPage> {
  final _formKey = GlobalKey<FormState>();
  final _fullName = TextEditingController();
  final _numberPhone = TextEditingController();
  final _email = TextEditingController();
  final _password = TextEditingController();
  final _rt = TextEditingController();
  final _rw = TextEditingController();
  final _desa = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    _fullName.dispose();
    _numberPhone.dispose();
    _email.dispose();
    _password.dispose();
    super.dispose();
  }

  File? _image;

  Future<void> _pickImage(ImageSource source) async {
    final picker = ImagePicker();
    final pickedImage = await picker.pickImage(source: source);

    if (pickedImage != null) {
      setState(() {
        _image = File(pickedImage.path);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider<AuthBloc>(
        create: (context) =>
            AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
        child: SafeArea(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 16.0),
            child: BlocConsumer<AuthBloc, AuthState>(
              listener: (context, state) {
                if (state is SuccessAuthState) {
                  context.loaderOverlay.hide();
                  if (state.role == "USER") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeUserPage()),
                        (route) => false);
                  }
                  if (state.role == "ADMIN") {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(
                            builder: (context) => const HomeAdminPage()),
                        (route) => false);
                  }
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
                return SingleChildScrollView(
                  child: Form(
                    key: _formKey,
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      children: [
                        SizedBox(
                          height: 5.h,
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
                          height: 26,
                        ),
                        GestureDetector(
                          onTap: () async {
                            await showModalBottomSheet(
                                context: context,
                                builder: (context) => Container(
                                      padding: const EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              _pickImage(ImageSource.gallery);
                                            },
                                            child: const Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.image,
                                                  size: 45,
                                                ),
                                                Text("galery")
                                              ],
                                            ),
                                          ),
                                          GestureDetector(
                                            onTap: () {
                                              _pickImage(ImageSource.camera);
                                            },
                                            child: const Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                Icon(
                                                  Icons.camera,
                                                  size: 45,
                                                ),
                                                Text("camera")
                                              ],
                                            ),
                                          ),
                                        ],
                                      ),
                                    ));
                          },
                          child: Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: _image == null
                                  ? Container(
                                      width: 180,
                                      height: 180,
                                      decoration: const BoxDecoration(
                                        shape: BoxShape.circle,
                                        color: Colors.grey,
                                      ),
                                      child: const Center(
                                        child: Icon(
                                          Icons.image,
                                          size: 45,
                                        ),
                                      ),
                                    )
                                  : Image.file(_image!,
                                      width: 180,
                                      height: 180,
                                      fit: BoxFit.cover),
                            ),
                          ),
                        ),
                        const SizedBox(
                          height: 29,
                        ),
                        CustomFormWidget(
                          controller: _fullName,
                          obsecure: false,
                          hint: "Masukkan Nama Lengkap",
                          label: "Nama Lengkap",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomFormWidget(
                          controller: _numberPhone,
                          obsecure: false,
                          hint: "Masukkan Nomor Telepon",
                          label: "Nomor Telepon",
                          inputType: TextInputType.number,
                          inputFormaters: [
                            FilteringTextInputFormatter.digitsOnly
                          ],
                        ),
                        const SizedBox(
                          height: 14,
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
                          height: 14,
                        ),
                        CustomFormWidget(
                          controller: _rt,
                          obsecure: false,
                          hint: "Masukkan RT",
                          label: "Rt",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomFormWidget(
                          controller: _rw,
                          obsecure: false,
                          hint: "Masukkan RW",
                          label: "Rw",
                        ),
                        const SizedBox(
                          height: 14,
                        ),
                        CustomFormWidget(
                          controller: _desa,
                          obsecure: false,
                          hint: "Masukkan Desa",
                          label: "Desa",
                        ),
                        const SizedBox(
                          height: 35,
                        ),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              FocusScope.of(context).unfocus();
                              context.read<AuthBloc>().add(
                                    RegisterAuth(
                                      _fullName.text,
                                      _numberPhone.text,
                                      _email.text,
                                      _password.text,
                                      _image,
                                      _rt.text,
                                      _rw.text,
                                      _desa.text,
                                    ),
                                  );
                            }
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
                          onTap: () {
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
                        ),
                        const SizedBox(
                          height: 100,
                        )
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
        ),
      ),
    );
  }
}
