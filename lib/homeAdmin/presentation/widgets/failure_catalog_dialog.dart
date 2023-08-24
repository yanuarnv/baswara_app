import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:google_fonts/google_fonts.dart';

class FailureCatalogDialog extends StatelessWidget {
  final String msg;
  const FailureCatalogDialog({super.key, required this.msg});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          SvgPicture.asset("assets/icons/icon_failure_red.svg"),
          const SizedBox(
            height: 14,
          ),
          Text(
            msg,
            style: GoogleFonts.inter(
              color: const Color(0xffC72D2D),
              fontWeight: FontWeight.w700,
              fontSize: 20,
            ),
          ),
          const SizedBox(
            height: 29,
          ),
          ElevatedButton(
            style: ElevatedButton.styleFrom(
                backgroundColor: const Color(0xffC72D2D)),
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
