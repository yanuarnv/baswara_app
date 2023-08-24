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
import '../widgets/success_catalog_dialog.dart';

class EditCatalogPage extends StatefulWidget {
  final String name;
  final String tautan;
  final String imgUrl;
  final String id;

  const EditCatalogPage(
      {super.key,
      required this.name,
      required this.tautan,
      required this.imgUrl,
      required this.id});

  @override
  State<EditCatalogPage> createState() => _EditCatalogPageState();
}

class _EditCatalogPageState extends State<EditCatalogPage> {
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
  void initState() {
    // TODO: implement initState
    nameCatalog.text = widget.name;
    tautanCatalog.text = widget.tautan;
    super.initState();
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
          "Edit Catalog",
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
            if (state is SuccesCatallogAdmin) {
              context.loaderOverlay.hide();
              showDialog(
                  context: context,
                  builder: (_) => const SuccesCatalogDialog(
                        msg: "Sukses Edit Catalog",
                      ));
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
                                  child: Image.network(widget.imgUrl),
                                ),
                        ),
                        const Spacer(),
                        ElevatedButton(
                          onPressed: () {
                            if (_formKey.currentState!.validate()) {
                              catalogcontext.read<AdminBloc>().add(
                                    EditCatalogAdmin(
                                        widget.id,
                                        nameCatalog.text,
                                        tautanCatalog.text,
                                        _image),
                                  );
                            }
                          },
                          child: const Text("Edit"),
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
