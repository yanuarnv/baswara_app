import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:baswara_app/homeUser/presentation/manager/home_user_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sizer/sizer.dart';

import '../../../core/utility.dart';

class RiwayatBerlangsungWidget extends StatefulWidget {
  const RiwayatBerlangsungWidget({super.key});

  @override
  State<RiwayatBerlangsungWidget> createState() =>
      _RiwayatBerlangsungWidgetState();
}

class _RiwayatBerlangsungWidgetState extends State<RiwayatBerlangsungWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (context) => HomeUserBloc(
        RepositoryProvider.of<HomeUserRepository>(context),
      )..add(GetRiwayatUser("PENDING")),
      child: BlocBuilder<HomeUserBloc, HomeUserState>(
        builder: (context, state) {
          return RefreshIndicator(
            onRefresh: () async {
              await Future.delayed(
                const Duration(),
                () {
                  context.read<HomeUserBloc>().add(GetRiwayatUser("PENDING"));
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
                      return SizedBox(
                        height: 90.h,
                        width: double.infinity,
                        child: ListView.builder(
                          padding: const EdgeInsets.all(20),
                          shrinkWrap: true,
                          itemCount: state.data.data.length,
                          itemBuilder: (c, i) => Container(
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
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Text(
                                  "11 Agustus 2023",
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
                                      state.data.data[i].totalPrice.toString(),
                                      style: GoogleFonts.poppins(
                                        fontSize: 15,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w500,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
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
    );
  }
}
