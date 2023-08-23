import 'dart:io';

import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:image_picker/image_picker.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../homeUser/presentation/manager/home_user_bloc.dart';
import '../../../widget/no_internet_dialog.dart';

class TambahCatalogPage extends StatefulWidget {
  const TambahCatalogPage({super.key});

  @override
  State<TambahCatalogPage> createState() => _TambahCatalogPageState();
}

class _TambahCatalogPageState extends State<TambahCatalogPage> {
  final _formKey = GlobalKey<FormState>();
  File? _image;
  final nameCatalog = TextEditingController();
  final tautanCatalog = TextEditingController();

  @override
  void dispose() {
    // TODO: implement dispose
    nameCatalog.dispose();
    tautanCatalog.dispose();
    super.dispose();
  }

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
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back, size: 24),
          onPressed: () {
            Navigator.pop(context);
          },
        ),
        backgroundColor: ColorValue.primary,
        centerTitle: true,
        title: Text(
          "Tambah Catalog",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
      ),
      body: BlocProvider(
        create: (context) =>
            AdminBloc(RepositoryProvider.of<AdminRepository>(context)),
        child: BlocConsumer<AdminBloc, AdminState>(
          listener: (context, state) {
            if (state is NoInternetHomeUser) {
              context.loaderOverlay.hide();
              showDialog(
                  context: context,
                  builder: (context) => const NoInternetDialog());
            }
            if (state is LoadingAdminState) {
              context.loaderOverlay.show();
            }
            if (state is SuccesAddCatallogAdmin) {
              context.loaderOverlay.hide();

              Utility(context).showSnackbar("Sukses Tambah Catalog",
                  color: ColorValue.primary);
            }
            if (state is FailureAdminState) {
              context.loaderOverlay.hide();
              Utility(context).showSnackbar(state.msg);
            }
          },
          builder: (catalogcontext, state) {
            return SingleChildScrollView(
              child: SizedBox(
                height: 88.h,
                child: Form(
                  key: _formKey,
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 16.0),
                    child: Column(
                      children: [
                        const SizedBox(
                          height: 54,
                        ),
                        CustomFormWidget(
                          obsecure: false,
                          controller: nameCatalog,
                          hint: "Masukkan Nama Produk",
                          label: "Nama Produk",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        CustomFormWidget(
                          controller: tautanCatalog,
                          obsecure: false,
                          hint: "Masukkan Tautan Produk",
                          label: "Tautan",
                        ),
                        const SizedBox(
                          height: 20,
                        ),
                        GestureDetector(
                          onTap: () {
                            showModalBottomSheet(
                                context: context,
                                builder: (_) => Container(
                                      padding: EdgeInsets.all(16.0),
                                      child: Row(
                                        mainAxisSize: MainAxisSize.min,
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceEvenly,
                                        children: <Widget>[
                                          GestureDetector(
                                            onTap: () {
                                              _pickImage(ImageSource.gallery);
                                              Navigator.pop(context);
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
                          child: _image != null
                              ? SizedBox(
                                  height: 160,
                                  width: double.infinity,
                                  child: Image.file(_image!),
                                )
                              : Container(
                                  width: double.infinity,
                                  height: 160,
                                  decoration: BoxDecoration(
                                      border: Border.all(
                                        color: ColorValue.primary,
                                        width: 1.sp,
                                      ),
                                      borderRadius: BorderRadius.circular(10)),
                                  child: const Center(
                                    child: Icon(
                                      Icons.camera_alt,
                                      color: ColorValue.primary,
                                      size: 48,
                                    ),
                                  ),
                                ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              if (_image != null) {
                                catalogcontext.read<AdminBloc>().add(
                                      AddCatalogAdmin(nameCatalog.text,
                                          tautanCatalog.text, _image!),
                                    );
                              } else {
                                showDialog(
                                  context: context,
                                  builder: (context) => AlertDialog(
                                    content: Column(
                                      mainAxisSize: MainAxisSize.min,
                                      children: [
                                        const Text(
                                          "Mohon Tambahkan\nFoto Catalog !",
                                          textAlign: TextAlign.center,
                                          style: TextStyle(
                                              fontWeight: FontWeight.w500,
                                              fontSize: 21),
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        ElevatedButton(
                                            onPressed: () {
                                              Navigator.pop(context);
                                            },
                                            child: const Text("oke"))
                                      ],
                                    ),
                                  ),
                                );
                              }
                            }
                          },
                          child: const Text("Simpan"),
                        ),
                        const SizedBox(
                          height: 20,
                        ),
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
