import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class UserSaldoWidget extends StatelessWidget {
  final int index;
  final Data user;
  final VoidCallback action;

  const UserSaldoWidget({
    super.key,
    required this.index,
    required this.user,
    required this.action,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.symmetric(vertical: 10),
      decoration: const BoxDecoration(
        border: Border(
          bottom: BorderSide(color: Colors.black, width: 1),
        ),
      ),
      child: Row(
        children: [
          Expanded(
            child: Center(
              child: Text(
                "${1 + index}",
                style: GoogleFonts.poppins(
                  fontSize: 16,
                ),
              ),
            ),
          ),
          Expanded(
            flex: 4,
            child: Text(
              user.name,
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: GestureDetector(
              onTap: action,
              child: const Center(
                  child: Icon(
                Icons.money,
                color: ColorValue.primary,
              )),
            ),
          ),
        ],
      ),
    );
  }
}
