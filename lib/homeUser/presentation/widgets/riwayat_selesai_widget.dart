import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:baswara_app/homeUser/presentation/manager/home_user_bloc.dart';
import 'package:baswara_app/homeUser/presentation/pages/detail_riwayat_selesai_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utility.dart';

class RiwayatSelesaiWidget extends StatefulWidget {
  const RiwayatSelesaiWidget({super.key});

  @override
  State<RiwayatSelesaiWidget> createState() => _RiwayatSelesaiWidgetState();
}

class _RiwayatSelesaiWidgetState extends State<RiwayatSelesaiWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeUserBloc(
        RepositoryProvider.of<HomeUserRepository>(context),
      )..add(GetRiwayatUser("SUCCESS")),
      child: BlocBuilder<HomeUserBloc, HomeUserState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                const Duration(),
                () {
                  context.read<HomeUserBloc>().add(GetRiwayatUser("SUCCESS"));
                },
              );
              return;
            },
            child: Stack(
              children: [
                ListView(),
                BlocConsumer<HomeUserBloc, HomeUserState>(
                  listener: (context, state) {
                    if (state is LoadingHomeUserState) {
                      context.loaderOverlay.show();
                    }
                    if (state is FailureHomeUserState) {
                      context.loaderOverlay.hide();
                      Utility(context).showSnackbar(state.msg);
                    }
                  },
                  builder: (context, state) {
                    if (state is SuccesGetRiwayatUser) {
                      context.loaderOverlay.hide();
                      if (state.data.data.isNotEmpty) {
                        return SizedBox(
                          height: 90.h,
                          width: double.infinity,
                          child: ListView.builder(
                            padding: const EdgeInsets.all(20),
                            shrinkWrap: true,
                            itemCount: state.data.data.length,
                            itemBuilder: (c, i) => Padding(
                              padding: const EdgeInsets.only(bottom: 10.0),
                              child: GestureDetector(
                                onTap: () {
                                  Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                          builder: (_) =>
                                              DetailRiwayatSelesaiPage(
                                                  model: state.data.data[i])));
                                },
                                child: Container(
                                  padding: const EdgeInsets.all(10),
                                  decoration: BoxDecoration(
                                      color: Colors.white,
                                      borderRadius: BorderRadius.circular(5),
                                      boxShadow: const [
                                        BoxShadow(
                                          color: Color.fromRGBO(0, 0, 0, 0.10),
                                          offset: Offset(0, 4),
                                          blurRadius: 4,
                                        )
                                      ]),
                                  child: Column(
                                    crossAxisAlignment:
                                        CrossAxisAlignment.start,
                                    children: [
                                      Text(
                                        DateFormat('d MMMM y').format(
                                            state.data.data[i].createdAt),
                                        style: GoogleFonts.poppins(
                                          fontSize: 14,
                                        ),
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Berat Sampah",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            "${state.data.data[i].quantity} Kg",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: ColorValue.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.spaceBetween,
                                        children: [
                                          Text(
                                            "Total Harga",
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: Colors.black,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          ),
                                          Text(
                                            Utility(context).currencyFormat(
                                                state.data.data[i].totalPrice),
                                            style: GoogleFonts.poppins(
                                              fontSize: 15,
                                              color: ColorValue.primary,
                                              fontWeight: FontWeight.w500,
                                            ),
                                          )
                                        ],
                                      )
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                        );
                      } else {
                        return Center(
                          child: Text(
                            "Tidak ada Riwayat",
                            style: GoogleFonts.inter(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                        );
                      }
                    }
                    return const SizedBox.shrink();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }
}
