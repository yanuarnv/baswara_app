import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/presentation/widgets/product_item_widget.dart';
import 'package:baswara_app/widget/add_product_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utility.dart';
import '../../../widget/delete_product_dialog.dart';
import '../../../widget/edit_product_dialog.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/admin_repository.dart';
import '../manager/admin_bloc.dart';

class JenisSampahWidget extends StatefulWidget {
  const JenisSampahWidget({super.key});

  @override
  State<JenisSampahWidget> createState() => _JenisSampahWidgetState();
}

class _JenisSampahWidgetState extends State<JenisSampahWidget> {
  ValueNotifier<int> filterItem = ValueNotifier(0);
  ValueNotifier<List<Product>> dataProduct = ValueNotifier([]);
  final List<String> categoryList = [
    "Semua",
    "Plastik",
    "Kertas",
    "Besi",
  ];

  @override
  void dispose() {
    // TODO: implement dispose
    filterItem.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
        body: BlocProvider<AdminBloc>(
          create: (context) =>
              AdminBloc(RepositoryProvider.of<AdminRepository>(context))
                ..add(GetProduct()),
          child: BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(milliseconds: 500),
                    () {
                      BlocProvider.of<AdminBloc>(context).add(GetProduct());
                    },
                  );
                  return;
                },
                child: Stack(
                  children: [
                    ListView(),
                    SingleChildScrollView(
                      child: BlocConsumer<AdminBloc, AdminState>(
                        listener: (context, state) {
                          if (state is NoConnection) {
                            showDialog(
                                context: context,
                                builder: (context) => const AlertDialog(
                                      content: Text("NO internet"),
                                    ));
                          }
                          if(state is SuccesAddproduct){
                            BlocProvider.of<AdminBloc>(context).add(GetProduct());
                          }
                          if(state is LoadingAdminState){
                            context.loaderOverlay.show();
                          }
                          if(state is FailureAdminState){
                            context.loaderOverlay.hide();
                            Utility(context).showSnackbar(state.msg);
                          }
                        },
                        builder: (context, state) {

                          if (state is SuccesGetProduct) {
                            context.loaderOverlay.hide();
                            dataProduct.value = List.from(state.data);
                            return SizedBox(
                              height: 90.h,
                              child: Padding(
                                padding: const EdgeInsets.symmetric(
                                    horizontal: 16.0),
                                child: Column(
                                  children: [
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ValueListenableBuilder(
                                        valueListenable: filterItem,
                                        builder: (context, value, _) {
                                          return Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment
                                                    .spaceBetween,
                                            children: List<Widget>.generate(
                                              4,
                                              (int index) {
                                                return ChoiceChip(
                                                  selectedColor:
                                                      ColorValue.primary,
                                                  backgroundColor:
                                                      Colors.white,
                                                  shape:
                                                      RoundedRectangleBorder(
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
                                                    side: const BorderSide(
                                                      color:
                                                          ColorValue.primary,
                                                    ),
                                                  ),
                                                  label: Row(
                                                    children: [
                                                      if (value == index)
                                                        const Icon(
                                                          Icons.check,
                                                          color: Colors.white,
                                                          size: 12,
                                                        ),
                                                      const SizedBox(
                                                        width: 5,
                                                      ),
                                                      Text(
                                                        categoryList[index],
                                                        style: GoogleFonts.inter(
                                                            fontSize: 12,
                                                            color: value ==
                                                                    index
                                                                ? Colors.white
                                                                : ColorValue
                                                                    .primary),
                                                      ),
                                                    ],
                                                  ),
                                                  selected: value == index,
                                                  onSelected:
                                                      (bool selected) {
                                                    filterItem.value = index;
                                                    if (index == 0) {
                                                      dataProduct.value =
                                                          state.data;
                                                    } else {
                                                      dataProduct
                                                          .value = List<
                                                                  Product>.from(
                                                              state.data)
                                                          .where((element) =>
                                                              element
                                                                  .categoriesId
                                                                  .id ==
                                                              index)
                                                          .toList();
                                                    }
                                                  },
                                                );
                                              },
                                            ).toList(),
                                          );
                                        }),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    FocusScope(
                                      node: FocusScopeNode(),
                                      child: TextField(
                                        style:
                                            GoogleFonts.poppins(fontSize: 16),
                                        decoration: InputDecoration(
                                            border: const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorValue.primary),
                                            ),
                                            enabledBorder:
                                                const OutlineInputBorder(
                                              borderSide: BorderSide(
                                                  color: ColorValue.primary),
                                            ),
                                            hintText: "Search...",
                                            hintStyle: GoogleFonts.poppins(
                                                fontSize: 16,
                                                color: ColorValue.primary),
                                            isDense: true,
                                            contentPadding:
                                                const EdgeInsets.all(10),
                                            suffixIcon: const Icon(
                                              Icons.search,
                                              size: 24,
                                              color: ColorValue.primary,
                                            )),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 25,
                                    ),
                                    Expanded(
                                      child: Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(5)),
                                        child: Column(
                                          children: [
                                            Container(
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      vertical: 10),
                                              decoration: const BoxDecoration(
                                                border: Border(
                                                  bottom: BorderSide(
                                                      color: Colors.black,
                                                      width: 1),
                                                ),
                                              ),
                                              child: Row(
                                                children: [
                                                  Expanded(
                                                    child: Center(
                                                      child: Text(
                                                        "No",
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 4,
                                                    child: Text(
                                                      "Nama",
                                                      style:
                                                          GoogleFonts.poppins(
                                                        fontSize: 16,
                                                      ),
                                                    ),
                                                  ),
                                                  Expanded(
                                                    flex: 2,
                                                    child: Center(
                                                      child: Text(
                                                        "Aksi",
                                                        style: GoogleFonts
                                                            .poppins(
                                                          fontSize: 16,
                                                        ),
                                                      ),
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ),
                                            Expanded(
                                              child: ValueListenableBuilder<
                                                  List<Product>>(
                                                valueListenable: dataProduct,
                                                builder: (context, value, _) {
                                                  return ListView.builder(
                                                    shrinkWrap: true,
                                                    itemCount: value.length,
                                                    itemBuilder: (c, index) =>
                                                        ProductItemWidget(
                                                      product: value[index],
                                                      index: index,
                                                      edit: () async {
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                const EditProductDialog());
                                                      },
                                                      delete: () async {
                                                        await showDialog(
                                                            context: context,
                                                            builder: (context) =>
                                                                const DeleteProductDialog());
                                                      },
                                                    ),
                                                  );
                                                },
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                    ),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                    ElevatedButton(
                                        onPressed: () async {
                                          await showDialog(
                                              context: context,
                                              builder: (_) =>
                                                  AddProductDialog(
                                                    blocContext: context,
                                                  ));
                                        },
                                        child: Text(
                                          "Tambah Jenis Sampah",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                            fontWeight: FontWeight.w500,
                                            color: Colors.white,
                                          ),
                                        )),
                                    const SizedBox(
                                      height: 20,
                                    ),
                                  ],
                                ),
                              ),
                            );
                          }
                          return SizedBox.shrink();
                        },
                      ),
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
