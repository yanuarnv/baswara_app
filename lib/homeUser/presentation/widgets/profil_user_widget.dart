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
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (_) =>
              AuthBloc(RepositoryProvider.of<AuthRepository>(context)),
        ),
      ],
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
                        builder: (_) =>
                            LogoutDialogWidget(blocContext: context,));
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
              Navigator.pushReplacement(context, MaterialPageRoute(
                  builder: (context) => const OnBoardingPage()));
            }
            if(state is LoadingAuthState){
              context.loaderOverlay.show();
            }
            if(state is FailureAuthState){
              context.loaderOverlay.hide();
              Utility(context).showSnackbar(state.msg);
            }
          },
          child: BlocBuilder<AuthBloc, AuthState>(
            builder: (context, state) {
              return RefreshIndicator(
                onRefresh: () async {
                  await Future.delayed(
                    const Duration(),
                        () {},
                  );
                  return;
                },
                child: Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 16.0),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const SizedBox(
                        height: 26,
                      ),
                      Center(
                        child: Container(
                          width: 180,
                          height: 180,
                          decoration: BoxDecoration(
                              color: Colors.grey,
                              borderRadius: BorderRadius.circular(90)),
                          child: const Icon(Icons.person, size: 60),
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
                        "Jodan will smith",
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
                        "0882003251891",
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
                        "jodansmith@imagine.com",
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
              );
            },
          ),
        ),
      ),
    );
  }
}
