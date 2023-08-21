import 'package:baswara_app/homeAdmin/presentation/pages/aksi_input_sampah_page.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import '../../../core/color_value.dart';
import '../../../homeUser/domain/entities/home_user_entity.dart';

class UserItemWidget extends StatelessWidget {
  final int index;
  final Data user;

  const UserItemWidget({
    super.key,
    required this.index,
    required this.user,
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
            child: Align(
              alignment: Alignment.centerLeft,
              child: IconButton(
                icon: const Icon(Icons.remove_red_eye),
                onPressed: () {
                  showDialog(
                    context: context,
                    builder: (_) => AlertDialog(
                      actions: [
                        ElevatedButton(
                          onPressed: () {
                            Navigator.pop(context);
                          },
                          child: const Text(
                            "oke",
                          ),
                        )
                      ],
                      content: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Text(
                            "Saldo",
                            style: GoogleFonts.poppins(
                                fontSize: 16, fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 10,
                          ),
                          Text(
                            "Rp ${user.savings}",
                            style: GoogleFonts.poppins(
                              fontSize: 16,
                            ),
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: IconButton(
                visualDensity: VisualDensity.compact,
                onPressed: () {
                  Navigator.push(
                      context,
                      MaterialPageRoute(
                          builder: (context) => const AksiInputSampahPage()));
                },
                icon: const Icon(
                  Icons.add,
                  color: ColorValue.primary,
                )),
          ),
        ],
      ),
    );
  }
}
