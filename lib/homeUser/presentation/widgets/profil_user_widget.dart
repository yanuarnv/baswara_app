import 'package:baswara_app/homeUser/domain/repositories/home_user_repository.dart';
import 'package:baswara_app/homeUser/presentation/manager/home_user_bloc.dart';
import 'package:baswara_app/homeUser/presentation/pages/edit_profile_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:loader_overlay/loader_overlay.dart';

import '../../../authentication/domain/repositories/auth_repository.dart';
import '../../../authentication/presentation/manager/auth_bloc.dart';
import '../../../core/color_value.dart';
import '../../../core/utility.dart';
import '../../../onBoarding/presentation/pages/onboarding_page.dart';
import '../../../widget/logout_dialog_widget.dart';

class ProfilUserWidget extends StatefulWidget {
  const ProfilUserWidget({super.key});

  @override
  State<ProfilUserWidget> createState() => _ProfilUserWidgetState();
}

class _ProfilUserWidgetState extends State<ProfilUserWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) =>
          HomeUserBloc(RepositoryProvider.of<HomeUserRepository>(context))
            ..add(GetUserProfile()),
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: ColorValue.primary,
          centerTitle: true,
          title: Text(
            "Profil",
            style: GoogleFonts.poppins(
              fontSize: 20,
              fontWeight: FontWeight.w600,
              color: Colors.white,
            ),
          ),
          actions: [
            BlocBuilder<AuthBloc, AuthState>(
              builder: (context, state) {
                return IconButton(
                  onPressed: () async {
                    await showDialog(
                        context: context,
                        builder: (_) => LogoutDialogWidget(
                              blocContext: context,
                            ));
                  },
                  icon: const Icon(
                    Icons.logout,
                    size: 24,
                  ),
                );
              },
            ),
          ],
        ),
        body: BlocListener<AuthBloc, AuthState>(
          listener: (context, state) {
            if (state is SuccesLogout) {
              context.loaderOverlay.hide();
              Navigator.pushReplacement(
                  context,
                  MaterialPageRoute(
                      builder: (context) => const OnBoardingPage()));
            }
            if (state is LoadingAuthState) {
              context.loaderOverlay.show();
            }
            if (state is FailureAuthState) {
              context.loaderOverlay.hide();
              Utility(context).showSnackbar(state.msg);
            }
          },
          child: BlocListener<HomeUserBloc, HomeUserState>(
            listener: (context, state) {
              if (state is LoadingHomeUserState) {
                context.loaderOverlay.show();
              }
              if (state is FailureHomeUserState) {
                context.loaderOverlay.hide();
                Utility(context).showSnackbar(state.msg);
              }
            },
            child: BlocBuilder<HomeUserBloc, HomeUserState>(
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
            ),
          ),
        ),
      ),
    );
  }
}
