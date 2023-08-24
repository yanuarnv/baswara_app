import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/core/utility.dart';
import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/jenis_sampah_page.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/profile_users_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../widget/no_internet_dialog.dart';
import '../manager/admin_bloc.dart';

class DashBoardAdminWidget extends StatefulWidget {
  const DashBoardAdminWidget({super.key});

  @override
  State<DashBoardAdminWidget> createState() => _DashBoardAdminWidgetState();
}

class _DashBoardAdminWidgetState extends State<DashBoardAdminWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) =>
            AdminBloc(RepositoryProvider.of<AdminRepository>(context))
              ..add(GetReport()),
        child: BlocBuilder<AdminBloc, AdminState>(
          builder: (context, state) {
            return RefreshIndicator(
              onRefresh: () async {
                await Future.delayed(
                  const Duration(),
                  () {
                    context.read<AdminBloc>().add(GetReport());
                  },
                );
                return;
              },
              child: Stack(
                children: [
                  ListView(
                    physics: AlwaysScrollableScrollPhysics(),
                  ),
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
                      if (state is SuccesGetReport) {
                        context.loaderOverlay.hide();
                        return Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 16.0),
                          child: SingleChildScrollView(
                            physics: AlwaysScrollableScrollPhysics(),
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                const SizedBox(
                                  height: 21,
                                ),
                                Text(
                                  "Selamat Datang, Admin!",
                                  style: GoogleFonts.poppins(
                                    fontSize: 20,
                                    fontWeight: FontWeight.w600,
                                    color: ColorValue.primary,
                                  ),
                                ),
                                Text(
                                  "Tetap pantau sampah yang masuk agar sampah dapat terdaur ulang dengan baik",
                                  style: GoogleFonts.poppins(
                                    fontSize: 16,
                                  ),
                                ),
                                const SizedBox(
                                  height: 16,
                                ),
                                ClipRRect(
                                  borderRadius: BorderRadius.circular(4),
                                  child: Container(
                                    padding: const EdgeInsets.all(10),
                                    decoration: const BoxDecoration(
                                        color: Colors.white,
                                        border: Border(
                                            left: BorderSide(
                                                color: ColorValue.primary,
                                                width: 3))),
                                    child: Row(
                                      children: [
                                        SvgPicture.asset(
                                            "assets/icons/icon_shoping_circle.svg"),
                                        const SizedBox(
                                          width: 21,
                                        ),
                                        Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              "Penjualan (Rp)",
                                              style: GoogleFonts.poppins(
                                                fontSize: 20,
                                                fontWeight: FontWeight.w500,
                                                color: ColorValue.primary,
                                              ),
                                            ),
                                            Text(
                                              NumberFormat.currency(
                                                      locale: 'id',
                                                      symbol: 'Rp ',
                                                      decimalDigits: 2)
                                                  .format(
                                                      state.data.data.price),
                                              style: GoogleFonts.poppins(
                                                fontSize: 24,
                                                fontWeight: FontWeight.w600,
                                                color: Colors.black,
                                              ),
                                            )
                                          ],
                                        )
                                      ],
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const ProfileUsersPage()));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              left: BorderSide(
                                                  color: ColorValue.primary,
                                                  width: 3))),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/icon_people.svg"),
                                          const SizedBox(
                                            width: 21,
                                          ),
                                          Text(
                                            "Pengguna Baswara",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: ColorValue.primary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 18,
                                ),
                                GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                        context,
                                        MaterialPageRoute(
                                            builder: (context) =>
                                                const JenisSampahPage()));
                                  },
                                  child: ClipRRect(
                                    borderRadius: BorderRadius.circular(4),
                                    child: Container(
                                      padding: const EdgeInsets.all(10),
                                      decoration: const BoxDecoration(
                                          color: Colors.white,
                                          border: Border(
                                              left: BorderSide(
                                                  color: ColorValue.primary,
                                                  width: 3))),
                                      child: Row(
                                        children: [
                                          SvgPicture.asset(
                                              "assets/icons/icon_trash_grey.svg"),
                                          const SizedBox(
                                            width: 21,
                                          ),
                                          Text(
                                            "Jenis Sampah ",
                                            style: GoogleFonts.poppins(
                                              fontSize: 20,
                                              fontWeight: FontWeight.w500,
                                              color: ColorValue.primary,
                                            ),
                                          )
                                        ],
                                      ),
                                    ),
                                  ),
                                ),
                                const SizedBox(
                                  height: 26,
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
    );
  }
}
