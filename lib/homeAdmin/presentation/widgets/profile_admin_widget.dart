import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/domain/repositories/admin_repository.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/utility.dart';
import '../../../homeUser/domain/repositories/home_user_repository.dart';
import '../../../homeUser/presentation/manager/home_user_bloc.dart';

class ProfileAdminWidget extends StatelessWidget {
  const ProfileAdminWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
          create: (context) =>
              HomeUserBloc(RepositoryProvider.of<HomeUserRepository>(context))
                ..add(GetUserProfile()),
          child: BlocConsumer<HomeUserBloc, HomeUserState>(
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
              if (state is SuccesGetProfile) {
                context.loaderOverlay.hide();
                return RefreshIndicator(
                  onRefresh: () async {
                    await Future.delayed(
                      const Duration(),
                      () {
                        context.read<HomeUserBloc>().add(GetUserProfile());
                      },
                    );
                    return;
                  },
                  child: SingleChildScrollView(
                    scrollDirection: Axis.vertical,
                    physics: const AlwaysScrollableScrollPhysics(),
                    child: Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 16.0),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          const SizedBox(
                            height: 26,
                          ),
                          Center(
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(90),
                              child: Image.network(
                                state.model.data.imageUrl,
                                fit: BoxFit.cover,
                                width: 180,
                                height: 180,
                              ),
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Container(
                            padding: const EdgeInsets.symmetric(
                                horizontal: 16, vertical: 14),
                            margin: const EdgeInsets.only(bottom: 39),
                            decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(10),
                                color: Colors.white,
                                boxShadow: const [
                                  BoxShadow(
                                      color: Colors.grey,
                                      blurRadius: 10,
                                      offset: Offset(0, 2)),
                                ]),
                            child: Row(
                              children: [
                                SvgPicture.asset(
                                  "assets/icons/icon_wallet.svg",
                                  width: 45,
                                  height: 45,
                                ),
                                const SizedBox(
                                  width: 9,
                                ),
                                Column(
                                  crossAxisAlignment:
                                      CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      "Saldo",
                                      style: GoogleFonts.poppins(
                                          fontSize: 16,
                                          fontWeight: FontWeight.w500,
                                          color: Colors.black),
                                    ),
                                    Text(
                                      "Rp ${state.model.data.savings}",
                                      style: GoogleFonts.poppins(
                                        fontSize: 20,
                                        fontWeight: FontWeight.w600,
                                        color: ColorValue.primary,
                                      ),
                                    )
                                  ],
                                )
                              ],
                            ),
                          ),
                          const SizedBox(
                            height: 40,
                          ),
                          Text(
                            "Nama",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            state.model.data.name,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff455A64),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "No. HP",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            state.model.data.phone,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff455A64),
                            ),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Email",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: Colors.black,
                            ),
                          ),
                          Text(
                            state.model.data.email,
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                              fontWeight: FontWeight.w500,
                              color: const Color(0xff455A64),
                            ),
                          ),
                          const SizedBox(
                            height: 80,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
