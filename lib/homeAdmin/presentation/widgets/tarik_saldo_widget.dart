import 'package:baswara_app/homeAdmin/presentation/widgets/success_catalog_dialog.dart';
import 'package:baswara_app/homeAdmin/presentation/widgets/user_saldo_widget.dart';
import 'package:baswara_app/widget/tarik_saldo_dialog.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../homeUser/domain/entities/home_user_entity.dart';
import '../../../widget/no_internet_dialog.dart';
import '../../domain/repositories/admin_repository.dart';
import '../manager/admin_bloc.dart';

class TarikSaldoWidget extends StatefulWidget {
  const TarikSaldoWidget({super.key});

  @override
  State<TarikSaldoWidget> createState() => _TarikSaldoWidgetState();
}

class _TarikSaldoWidgetState extends State<TarikSaldoWidget> {
  ValueNotifier<List<Data>> listUser = ValueNotifier([]);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        FocusScope.of(context).unfocus();
      },
      child: Scaffold(
        resizeToAvoidBottomInset: false,
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
                        if (state is LoadingAdminState) {
                          context.loaderOverlay.show();
                        }
                        if (state is SuccesTarikSaldo) {
                          context.loaderOverlay.hide();
                          showDialog(
                                  context: context,
                                  builder: (_) => const SuccesCatalogDialog(
                                      msg: "Sukses Tarik Saldo User"))
                              .then((value) {
                            BlocProvider.of<AdminBloc>(context)
                                .add(GetAlluser());
                          });
                        }
                        if (state is FailureAdminState) {
                          context.loaderOverlay.hide();
                          Utility(context).showSnackbar(state.msg);
                        }
                      },
                      builder: (bloccontext, state) {
                        if (state is SuccesGetAllUser) {
                          bloccontext.loaderOverlay.hide();
                          listUser.value = List.from(state.data);
                          return Padding(
                            padding: const EdgeInsets.only(
                                top: 15.0, left: 16, right: 16),
                            child: Column(
                              children: [
                                const SizedBox(
                                  height: 25,
                                ),
                                FocusScope(
                                  node: FocusScopeNode(),
                                  child: TextField(
                                    style: GoogleFonts.poppins(fontSize: 16),
                                    onChanged: (value) {
                                      final filtered =
                                          state.data.where((element) {
                                        return RegExp(value,
                                                caseSensitive: false)
                                            .hasMatch(element.name);
                                      }).toList();
                                      listUser.value = filtered;
                                    },
                                    decoration: InputDecoration(
                                        border: const OutlineInputBorder(
                                          borderSide: BorderSide(
                                              color: ColorValue.primary),
                                        ),
                                        enabledBorder: const OutlineInputBorder(
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
                                const SizedBox(height: 10),
                                Expanded(
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: BoxDecoration(
                                        color: Colors.white,
                                        borderRadius: BorderRadius.circular(5)),
                                    child: Column(
                                      children: [
                                        Container(
                                          padding: const EdgeInsets.symmetric(
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
                                              valueListenable: listUser,
                                              builder:
                                                  (context, listUservalue, _) {
                                                return ListView.builder(
                                                  shrinkWrap: true,
                                                  itemCount:
                                                      listUservalue.length,
                                                  itemBuilder: (c, index) =>
                                                      UserSaldoWidget(
                                                    index: index,
                                                    user: listUservalue[index],
                                                    action: () {
                                                      showDialog(
                                                        context: context,
                                                        builder: (_) =>
                                                            TarikSaldoDialog(
                                                          user: listUservalue[
                                                              index],
                                                          blocContext:
                                                              bloccontext,
                                                        ),
                                                      );
                                                    },
                                                  ),
                                                );
                                              }),
                                        ),
                                      ],
                                    ),
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
