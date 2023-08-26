import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:baswara_app/homeUser/presentation/manager/home_user_bloc.dart';
import 'package:baswara_app/homeUser/presentation/pages/catalog_user_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../widget/no_internet_dialog.dart';

class HomeUserWidget extends StatefulWidget {
  const HomeUserWidget({
    super.key,
  });

  @override
  State<HomeUserWidget> createState() => _HomeUserWidgetState();
}

class _HomeUserWidgetState extends State<HomeUserWidget> {
  int totalSaldo = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: ColorValue.primary,
        title: Text(
          "Baswara",
          style: GoogleFonts.poppins(
            fontSize: 20,
            fontWeight: FontWeight.w600,
            color: Colors.white,
          ),
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 13.0),
            child: SvgPicture.asset("assets/icons/icon_notif_appbar.svg"),
          )
        ],
      ),
      body: BlocProvider(
        create: (context) =>
            HomeUserBloc(RepositoryProvider.of<HomeUserRepository>(context))
              ..add(GetUserProfile()),
        child: BlocBuilder<HomeUserBloc, HomeUserState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  const Duration(),
                  () {
                    BlocProvider.of<HomeUserBloc>(context)
                        .add(GetUserProfile());
                  },
                );
                return;
              },
              child: SingleChildScrollView(
                physics: const AlwaysScrollableScrollPhysics(),
                child: BlocConsumer<HomeUserBloc, HomeUserState>(
                  listener: (context, state) {
                    if (state is NoInternetHomeUser) {
                      context.loaderOverlay.hide();
                      showDialog(
                          context: context,
                          builder: (context) => const NoInternetDialog());
                    }
                    if (state is LoadingHomeUserState) {
                      context.loaderOverlay.show();
                    }
                    if (state is SuccesGetProfile) {
                      totalSaldo = int.parse(state.model.data.savings);
                      context.read<HomeUserBloc>().add(GetCatalogUser());
                    }
                    if (state is SuccesGetCatalogUser) {
                      context.loaderOverlay.hide();
                    }
                    if (state is FailureHomeUserState) {
                      context.loaderOverlay.hide();
                      Utility(context).showSnackbar(state.msg);
                    }
                  },
                  builder: (context, state) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        children: [
                          const SizedBox(
                            height: 21,
                          ),
                          Container(
                            padding: const EdgeInsets.all(10),
                            decoration: BoxDecoration(
                              color: Colors.white,
                              borderRadius: BorderRadius.circular(10),
                            ),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Image.asset(
                                    "assets/images/dashboard_people.png"),
                                const SizedBox(
                                  height: 15,
                                ),
                                Text(
                                  "Total Saldo BASWARA:",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    fontWeight: FontWeight.w500,
                                    color: const Color(0xff909090),
                                  ),
                                ),
                                const SizedBox(
                                  height: 10,
                                ),
                                Text(
                                  Utility(context).currencyFormat(totalSaldo),
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    color: ColorValue.primary,
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 30,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              Text(
                                "Katalog Bertawa",
                                style: GoogleFonts.poppins(
                                  fontSize: 16,
                                  color: ColorValue.primary,
                                  fontWeight: FontWeight.w600,
                                ),
                              ),
                              GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (context) =>
                                              const CatalogUserPage()));
                                },
                                child: Text(
                                  "Selengkapnya",
                                  style: GoogleFonts.poppins(
                                    fontSize: 14,
                                    color: ColorValue.primary,
                                    fontWeight: FontWeight.w500,
                                  ),
                                ),
                              )
                            ],
                          ),
                          const SizedBox(
                            height: 14,
                          ),
                          Text(
                            "Gunakan uang untuk membeli kreasi produk dari sampah",
                            style: GoogleFonts.poppins(
                                fontSize: 12, color: const Color(0xff909090)),
                          ),
                          const SizedBox(
                            height: 13,
                          ),
                          state is SuccesGetCatalogUser
                              ? state.data.data.isEmpty
                                  ? SizedBox(
                                      height: 200,
                                      child: Center(
                                          child: Text(
                                        "Catalog tidak tersedia",
                                        style: GoogleFonts.poppins(
                                          fontWeight: FontWeight.w500,
                                          fontSize: 16,
                                        ),
                                      )),
                                    )
                                  : GridView.builder(
                                      physics:
                                          const NeverScrollableScrollPhysics(),
                                      itemCount: state.data.data.length > 4
                                          ? 4
                                          : state.data.data.length,
                                      primary: false,
                                      shrinkWrap: true,
                                      gridDelegate:
                                          const SliverGridDelegateWithFixedCrossAxisCount(
                                              crossAxisSpacing: 20,
                                              mainAxisSpacing: 14,
                                              crossAxisCount: 2),
                                      itemBuilder: (c, i) => Container(
                                            padding: const EdgeInsets.all(10),
                                            decoration: BoxDecoration(
                                                color: Colors.white,
                                                borderRadius:
                                                    BorderRadius.circular(10),
                                                boxShadow: [
                                                  BoxShadow(
                                                    color: Colors.grey.shade300,
                                                    offset: const Offset(0, 4),
                                                    blurRadius: 4,
                                                  )
                                                ]),
                                            child: Column(
                                              children: [
                                                Image.network(state
                                                    .data.data[i].imageUrl),
                                                const SizedBox(
                                                  height: 9,
                                                ),
                                                Text(
                                                  state.data.data[i].name,
                                                  style: GoogleFonts.poppins(
                                                      fontSize: 16,
                                                      fontWeight:
                                                          FontWeight.w600,
                                                      color:
                                                          ColorValue.primary),
                                                )
                                              ],
                                            ),
                                          ))
                              : GridView.builder(
                                  itemCount: 4,
                                  shrinkWrap: true,
                                  gridDelegate:
                                      const SliverGridDelegateWithFixedCrossAxisCount(
                                          crossAxisSpacing: 20,
                                          mainAxisSpacing: 14,
                                          crossAxisCount: 2),
                                  itemBuilder: (c, i) => Container(
                                        padding: const EdgeInsets.all(10),
                                        decoration: BoxDecoration(
                                            color: Colors.white,
                                            borderRadius:
                                                BorderRadius.circular(10),
                                            boxShadow: [
                                              BoxShadow(
                                                color: Colors.grey.shade300,
                                                offset: const Offset(0, 4),
                                                blurRadius: 4,
                                              )
                                            ]),
                                        child: Column(
                                          children: [
                                            Container(
                                              height: 98,
                                              color: Colors.grey,
                                            ),
                                            const SizedBox(
                                              height: 9,
                                            ),
                                            Text(
                                              "-",
                                              style: GoogleFonts.poppins(
                                                  fontSize: 16,
                                                  fontWeight: FontWeight.w600,
                                                  color: ColorValue.primary),
                                            )
                                          ],
                                        ),
                                      )),
                          const SizedBox(
                            height: 26,
                          ),
                        ],
                      ),
                    );
                  },
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
