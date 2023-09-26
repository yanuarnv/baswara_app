import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeAdmin/presentation/widgets/user_item_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../homeUser/domain/entities/home_user_entity.dart';
import '../../../widget/no_internet_dialog.dart';
import '../manager/admin_bloc.dart';

class SampahUserWidget extends StatefulWidget {
  const SampahUserWidget({super.key});

  @override
  State<SampahUserWidget> createState() => _SampahUserWidgetState();
}

class _SampahUserWidgetState extends State<SampahUserWidget> {
  ValueNotifier<List<Data>> dataUser = ValueNotifier([]);
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        backgroundColor: const Color(0xffF5F5F5),
        body: BlocProvider(
          create: (context) =>
              AdminBloc(RepositoryProvider.of<AdminRepository>(context))
                ..add(GetAlluser()),
          child: BlocBuilder<AdminBloc, AdminState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(),
                    () {
                      BlocProvider.of<AdminBloc>(context).add(GetAlluser());
                    },
                  );
                  return;
                },
                child: Stack(
                  children: [
                    ListView(),
                    BlocConsumer<AdminBloc, AdminState>(
                      listener: (context, state) {
                        if (state is NoConnection) {
                          context.loaderOverlay.hide();
                          showDialog(
                              context: context,
                              builder: (context) => const NoInternetDialog());
                        }
                        if (state is SuccesProductCRUD) {
                          context.loaderOverlay.hide();
                          BlocProvider.of<AdminBloc>(context).add(GetAlluser());
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
                        if (state is SuccesGetAllUser) {
                          dataUser.value = state.data;
                          context.loaderOverlay.hide();
                          return Container(
                            margin: const EdgeInsets.only(
                                top: 20, left: 16, right: 16),
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                                color: Colors.white,
                                borderRadius: BorderRadius.circular(5)),
                            child: Column(
                              children: [
                                FocusScope(
                                  node: FocusScopeNode(),
                                  child: ValueListenableBuilder(
                                      valueListenable: dataUser,
                                      builder: (context, listProduct, _) {
                                        return TextField(
                                          style:
                                              GoogleFonts.poppins(fontSize: 16),
                                          onChanged: (value) {
                                            final filtered =
                                                state.data.where((element) {
                                              return RegExp(value,
                                                      caseSensitive: false)
                                                  .hasMatch(element.name);
                                            }).toList();
                                            dataUser.value = filtered;
                                          },
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
                                        );
                                      }),
                                ),
                                const SizedBox(
                                  height: 20,
                                ),
                                Container(
                                  padding:
                                      const EdgeInsets.symmetric(vertical: 10),
                                  decoration: const BoxDecoration(
                                    color: Color(0xffE2FAE1),
                                    border: Border(
                                      bottom: BorderSide(
                                          color: Colors.black, width: 1),
                                    ),
                                  ),
                                  child: Row(
                                    children: [
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "No",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 4,
                                        child: Text(
                                          "Nama",
                                          style: GoogleFonts.poppins(
                                            fontSize: 16,
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            "Saldo",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                      Expanded(
                                        flex: 2,
                                        child: Center(
                                          child: Text(
                                            "Aksi",
                                            style: GoogleFonts.poppins(
                                              fontSize: 16,
                                            ),
                                          ),
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                                Expanded(
                                  child: ValueListenableBuilder(
                                    valueListenable: dataUser,
                                    builder: (context, value, _) {
                                      return ListView.builder(
                                        shrinkWrap: true,
                                        itemCount: value.length,
                                        itemBuilder: (c, index) =>
                                            UserItemWidget(
                                          index: index,
                                          user: value[index],
                                        ),
                                      );
                                    },
                                  ),
                                ),
                              ],
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
