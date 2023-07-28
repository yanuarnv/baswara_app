import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_value.dart';

class ProfilUserWidget extends StatefulWidget {
  const ProfilUserWidget({super.key});

  @override
  State<ProfilUserWidget> createState() => _ProfilUserWidgetState();
}

class _ProfilUserWidgetState extends State<ProfilUserWidget> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
        ),
        body: Center(
            child: Text(
      "Profile  page",
      style: TextStyle(fontSize: 20),
    )));
  }
}
