import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/detail_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../homeUser/domain/entities/home_user_entity.dart';
import '../../../widget/no_internet_dialog.dart';

class ProfileUsersWidget extends StatefulWidget {
  const ProfileUsersWidget({super.key});

  @override
  State<ProfileUsersWidget> createState() => _ProfileUsersWidgetState();
}

class _ProfileUsersWidgetState extends State<ProfileUsersWidget> {
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
                        if (state is FailureAdminState) {
                          context.loaderOverlay.hide();
                          Utility(context).showSnackbar(state.msg);
                        }
                      },
                      builder: (context, state) {
                        if (state is SuccesGetAllUser) {
                          context.loaderOverlay.hide();
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
                                                      Container(
                                                    padding: const EdgeInsets
                                                        .symmetric(
                                                        vertical: 10),
                                                    decoration:
                                                        const BoxDecoration(
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
                                                              "${1 + index}",
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
                                                            listUservalue[index]
                                                                .name,
                                                            style: GoogleFonts
                                                                .poppins(
                                                              fontSize: 16,
                                                            ),
                                                          ),
                                                        ),
                                                        Expanded(
                                                          flex: 2,
                                                          child:
                                                              GestureDetector(
                                                            onTap: () {
                                                              Navigator.push(
                                                                context,
                                                                MaterialPageRoute(
                                                                  builder: (context) =>
                                                                      DetailUserPage(
                                                                          model:
                                                                              listUservalue[index]),
                                                                ),
                                                              );
                                                            },
                                                            child: const Center(
                                                                child: Icon(Icons
                                                                    .remove_red_eye)),
                                                          ),
                                                        ),
                                                      ],
                                                    ),
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
