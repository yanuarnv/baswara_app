import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:sizer/sizer.dart';

class EditProductDialog extends StatelessWidget {
  const EditProductDialog({super.key});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          const CustomFormWidget(obsecure: false, label: "Nama Sampah"),
          const SizedBox(
            height: 36,
          ),
          DropdownButtonFormField<int>(
            decoration:  InputDecoration(
              isDense: true,
              labelText: 'Kategori Sampah',
              labelStyle: GoogleFonts.poppins(
                  fontSize: 16),
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: 0,
                child: Text('plastik',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    )),
              ),
              DropdownMenuItem(
                value: 1,
                child: Text('kertas',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    )),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text(
                  'besi',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
              // Add more items as needed
            ],
            onChanged: (value) {},
          ),
          const SizedBox(
            height: 30,
          ),
          Row(
            children: [
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: const Color(0xffECECEC),
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      "Batal",
                      style: GoogleFonts.poppins(
                          fontSize: 16, fontWeight: FontWeight.w500,color: const Color(0xff909090)),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: Container(
                  padding: const EdgeInsets.symmetric(vertical: 10),
                  decoration: BoxDecoration(
                      color: ColorValue.primary,
                      borderRadius: BorderRadius.circular(100)),
                  child: Center(
                    child: Text(
                      "Edit",
                      style: GoogleFonts.poppins(
                          fontSize: 16,
                          fontWeight: FontWeight.w500,
                          color: Colors.white),
                    ),
                  ),
                ),
              ),
            ],
          )
        ],
      ),
    );
  }
}
