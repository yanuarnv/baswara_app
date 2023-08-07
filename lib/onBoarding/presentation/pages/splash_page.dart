import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/presentation/pages/home_admin_page.dart';
import 'package:baswara_app/homeUser/presentation/pages/home_user_page.dart';
import 'package:baswara_app/onBoarding/presentation/manager/onboarding_bloc.dart';
import 'package:baswara_app/onBoarding/presentation/pages/onboarding_page.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class SplashPage extends StatelessWidget {
  const SplashPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: BlocProvider(
        create: (context) => OnboardingBloc()..add(CheckAuth()),
        child: BlocListener<OnboardingBloc,OnBoardingState>(
          listener: (context, state) {
            if (state is SuccesOnBoardingState) {
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const HomeAdminPage(),
                ),
              );
            }else{
              Navigator.of(context).pushReplacement(
                MaterialPageRoute(
                  builder: (context) => const OnBoardingPage(),
                ),
              );
            }
          },
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    "assets/images/trash_green.png",
                    width: 164,
                    height: 190,
                  ),
                ),
              ),
              Text(
                "Baswara",
                style: GoogleFonts.poppins(
                  color: ColorValue.primary,
                  fontWeight: FontWeight.w600,
                  fontSize: 32,
                ),
              ),
              Text(
                "Nabung Sampah Naik Umrah",
                style: GoogleFonts.poppins(
                  color: const Color(0xff464646),
                  fontWeight: FontWeight.w500,
                  fontSize: 16,
                ),
              ),
              const SizedBox(
                height: 67,
              )
            ],
          ),
        ),
      ),
    );
  }
}
