import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../core/utility.dart';
import '../../../homeUser/domain/repositories/home_user_repository.dart';
import '../../../homeUser/presentation/manager/home_user_bloc.dart';
import '../../../homeUser/presentation/pages/edit_profile_page.dart';

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
                  child: Stack(
                    children: [
                      ListView(),
                      Padding(
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
                                child: state.model.data.imageUrl != ""
                                    ? Image.network(
                                        state.model.data.imageUrl,
                                        fit: BoxFit.cover,
                                        width: 180,
                                        height: 180,
                                      )
                                    : Utility(context)
                                        .emptyProfileImg(state.model.data.name),
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
                            Text(
                              "Rt",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              state.model.data.rt,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff455A64),
                              ),
                            ),
                            Text(
                              "Rw",
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: Colors.black,
                              ),
                            ),
                            Text(
                              state.model.data.rt,
                              style: GoogleFonts.poppins(
                                fontSize: 16,
                                fontWeight: FontWeight.w500,
                                color: const Color(0xff455A64),
                              ),
                            ),
                            const Spacer(),
                            ElevatedButton(
                              onPressed: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        EditProfilePage(model: state.model),
                                  ),
                                );
                              },
                              child: Text("Ubah"),
                            ),
                            const SizedBox(
                              height: 20,
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                );
              }
              return const SizedBox.shrink();
            },
          )),
    );
  }
}
