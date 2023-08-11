import 'package:baswara_app/core/color_value.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

import '../homeAdmin/presentation/manager/admin_bloc.dart';

class DeleteProductDialog extends StatelessWidget {
  final int idProduct;
  final BuildContext blocContext;

  const DeleteProductDialog(
      {super.key, required this.blocContext, required this.idProduct});

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          Text(
            "Hapus Sampah",
            style: GoogleFonts.poppins(
                fontSize: 20,
                fontWeight: FontWeight.w700,
                color: const Color(0xff464646)),
          ),
          const SizedBox(
            height: 10,
          ),
          Text(
            "Apakah Anda yakin ingin menghapus sampah?",
            textAlign: TextAlign.center,
            style: GoogleFonts.montserrat(
                fontSize: 14,
                fontWeight: FontWeight.w500,
                color: const Color(0xff464646)),
          ),
          const SizedBox(
            height: 20,
          ),
          Row(
            children: [
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: const Color(0xffECECEC),
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        "Kembali",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: const Color(0xff909090)),
                      ),
                    ),
                  ),
                ),
              ),
              const SizedBox(
                width: 10,
              ),
              Expanded(
                child: GestureDetector(
                  onTap: () {
                    blocContext.read<AdminBloc>().add(
                          DeleteProduct(
                            idProduct.toString(),
                          ),
                        );
                    Navigator.pop(context);
                  },
                  child: Container(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    decoration: BoxDecoration(
                        color: ColorValue.primary,
                        borderRadius: BorderRadius.circular(100)),
                    child: Center(
                      child: Text(
                        "Yakin",
                        style: GoogleFonts.poppins(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.white),
                      ),
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
