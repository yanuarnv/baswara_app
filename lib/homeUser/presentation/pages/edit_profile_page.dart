import 'dart:io';

import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:baswara_app/homeUser/presentation/manager/home_user_bloc.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';

class EditProfilePage extends StatefulWidget {
  final HomeUserEntity model;

  const EditProfilePage({super.key, required this.model});

  @override
  State<EditProfilePage> createState() => _EditProfilePageState();
}

class _EditProfilePageState extends State<EditProfilePage> {
  File? _image;
  final TextEditingController _name = TextEditingController();
  final TextEditingController _noHp = TextEditingController();
  final TextEditingController _email = TextEditingController();
  final _fomrKey = GlobalKey<FormState>();

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
  void initState() {
    // TODO: implement initState
    _name.text = widget.model.data.name;
    _noHp.text = widget.model.data.phone;
    _email.text = widget.model.data.email;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorValue.primary,
          centerTitle: true,
          title: Text(
            "Edit Profil",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
        ),
        body: BlocProvider(
          create: (context) =>
              HomeUserBloc(RepositoryProvider.of<HomeUserRepository>(context)),
          child: BlocListener<HomeUserBloc, HomeUserState>(
            listener: (context, state) {
              if (state is SuccesUpdateProfile) {
                context.loaderOverlay.hide();
                Utility(context).showSnackbar("Profile berhasil diupdate",
                    color: ColorValue.primary);
              }
              if (state is LoadingHomeUserState) {
                context.loaderOverlay.show();
              }
              if (state is FailureHomeUserState) {
                context.loaderOverlay.hide();
                Utility(context).showSnackbar(state.msg);
              }
            },
            child: BlocBuilder<HomeUserBloc, HomeUserState>(
              builder: (context, state) {
                return SingleChildScrollView(
                  child: SizedBox(
                    height: 85.h,
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Form(
                        key: _fomrKey,
                        child: Column(
                          children: [
                            const SizedBox(
                              height: 26,
                            ),
                            GestureDetector(
                              onTap: () async {
                                await showModalBottomSheet(
                                    context: context,
                                    builder: (context) => Container(
                                          padding: EdgeInsets.all(16.0),
                                          child: Row(
                                            mainAxisSize: MainAxisSize.min,
                                            mainAxisAlignment:
                                                MainAxisAlignment.spaceEvenly,
                                            children: <Widget>[
                                              GestureDetector(
                                                onTap: () {
                                                  _pickImage(
                                                      ImageSource.gallery);
                                                },
                                                child: const Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                                  _pickImage(
                                                      ImageSource.camera);
                                                },
                                                child: const Column(
                                                  mainAxisSize:
                                                      MainAxisSize.min,
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
                                      ? Center(
                                          child: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(90),
                                            child: widget
                                                    .model.data.imageUrl.isEmpty
                                                ? Utility(context)
                                                    .emptyProfileImg(
                                                        widget.model.data.name)
                                                : Image.network(
                                                    widget.model.data.imageUrl,
                                                    fit: BoxFit.cover,
                                                    width: 180,
                                                    height: 180,
                                                    errorBuilder: (c, __, _) =>
                                                        Utility(context)
                                                            .emptyProfileImg(
                                                                widget
                                                                    .model
                                                                    .data
                                                                    .name)),
                                          ),
                                        )
                                      : Image.file(_image!,
                                          width: 180,
                                          height: 180,
                                          fit: BoxFit.cover),
                                ),
                              ),
                            ),
                            Text(
                              "Ubah foto Profil",
                              style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  fontWeight: FontWeight.w500,
                                  color: ColorValue.primary),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormWidget(
                              controller: _name,
                              obsecure: false,
                              hint: "Masukan Nama",
                              label: "Nama",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormWidget(
                              controller: _noHp,
                              obsecure: false,
                              hint: "Masukan No.HP",
                              label: "No Hp",
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                            CustomFormWidget(
                              controller: _email,
                              obsecure: false,
                              hint: "Masukan email",
                              label: "email",
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                context.read<HomeUserBloc>().add(
                                    UpdateUserProfile(_name.text, _email.text,
                                        _noHp.text, _image));
                              },
                              child: const Text("Ubah"),
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
        ),
      ),
    );
  }
}
