import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../widget/no_internet_dialog.dart';
import '../manager/admin_bloc.dart';
import '../widgets/category_item_widget.dart';

class InputHargaSampahWidget extends StatefulWidget {
  const InputHargaSampahWidget({super.key});

  @override
  State<InputHargaSampahWidget> createState() => _InputHargaSampahWidgetState();
}

class _InputHargaSampahWidgetState extends State<InputHargaSampahWidget> {
  final List<List<TextEditingController>> _listControllerText = [];
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        body: BlocProvider(
          create: (context) =>
              AdminBloc(RepositoryProvider.of<AdminRepository>(context))
                ..add(
                  GetAllCategory(),
                ),
          child: BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(),
                    () {
                      BlocProvider.of<AdminBloc>(context).add(GetAllCategory());
                    },
                  );
                  return;
                },
                child: Stack(
                  children: [
                    ListView(),
                    BlocConsumer<AdminBloc, AdminState>(
                      listener: (context, state) {
                        // TODO: implement listener
                        if (state is NoConnection) {
                          context.loaderOverlay.hide();
                          showDialog(
                              context: context,
                              builder: (context) => const NoInternetDialog());
                        }
                        if (state is SuccesUpdateHarga) {
                          context.loaderOverlay.hide();
                          Utility(context).showSnackbar("Success",
                              color: ColorValue.primary);
                          BlocProvider.of<AdminBloc>(context)
                              .add(GetAllCategory());
                        }
                        if (state is LoadingAdminState) {
                          context.loaderOverlay.show();
                        }
                        if (state is FailureAdminState) {
                          context.loaderOverlay.hide();
                          Utility(context).showSnackbar(state.msg);
                        }
                      },
                      builder: (context, state) {
                        if (state is SuccesGetAllCategory) {
                          for (int i = 0; i < state.data.length; i++) {
                            _listControllerText.add([]);
                            for (int j = 0;
                                j < state.data[i].products.length;
                                j++) {
                              _listControllerText[i]
                                  .add(TextEditingController());
                            }
                          }
                          context.loaderOverlay.hide();
                          return SingleChildScrollView(
                            child: Padding(
                              padding:
                                  const EdgeInsets.symmetric(horizontal: 16.0),
                              child: Column(
                                crossAxisAlignment: CrossAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 30,
                                  ),
                                  Text(
                                    "Masukkan Harga Sampah",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 20,
                                      fontWeight: FontWeight.w600,
                                      color: ColorValue.primary,
                                    ),
                                  ),
                                  Text(
                                    "Masukkan harga sesuai informasi dari pengepul",
                                    style: GoogleFonts.montserrat(
                                      fontSize: 14,
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 27,
                                  ),
                                  Form(
                                    key: _formKey,
                                    child: ListView.builder(
                                      shrinkWrap: true,
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.data.length,
                                      itemBuilder: (context, i) =>
                                          CategoryItemWidget(
                                        data: state.data[i],
                                        controller: _listControllerText[i],
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                  ElevatedButton(
                                    onPressed: () {
                                      if (_formKey.currentState!.validate()) {
                                        List<Map<String, dynamic>> items = [];
                                        for (int x = 0;
                                            x < state.data.length;
                                            x++) {
                                          for (int y = 0;
                                              y < state.data[x].products.length;
                                              y++) {
                                            items.add({
                                              "id":
                                                  state.data[x].products[y].id,
                                              "price": int.parse(
                                                  _listControllerText[x][y]
                                                      .text)
                                            });
                                          }
                                        }
                                        context.read<AdminBloc>().add(
                                              UpdateHargaSampah(items),
                                            );
                                      }
                                    },
                                    child: Text(
                                      "Simpan",
                                      style: GoogleFonts.poppins(
                                        fontSize: 16,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 20,
                                  ),
                                ],
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ],
                ),
              );
            },
          ),
        ),
      ),
    );
  }
}
