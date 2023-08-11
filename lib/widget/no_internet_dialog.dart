import 'package:baswara_app/core/color_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

import '../homeAdmin/presentation/manager/admin_bloc.dart';

class NoInternetDialog extends StatelessWidget {
  const NoInternetDialog({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      title: Align(
        alignment: Alignment.topRight,
        child: IconButton(
            visualDensity: VisualDensity.compact,
            onPressed: () {
              Navigator.pop(context);
            },
            icon: const Icon(Icons.close)),
      ),
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/icon_no_internet.svg"),
          const SizedBox(
            height: 25,
          ),
          Text(
            "Yah, Jaringan Anda\nTerputus",
            textAlign: TextAlign.center,
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xff464646)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Pastikan smartphone Anda terhubung ke jaringan",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xff464646)),
          ),
          const SizedBox(
            height: 20,
          ),
        ],
      ),
    );
  }
}
