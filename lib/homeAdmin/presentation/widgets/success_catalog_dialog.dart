import 'package:baswara_app/core/color_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class SuccesCatalogDialog extends StatelessWidget {
  final String msg;
  const SuccesCatalogDialog({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/icon_verify_green.svg"),
          const SizedBox(
            height: 14,
          ),
          Text(
            msg,
            style: GoogleFonts.inter(
              color: ColorValue.primary,
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          ElevatedButton(
            onPressed: () {
              Navigator.pop(context);
            },
            child: const Text(
              "Kembali",
            ),
          )
        ],
      ),
    );
  }
}
