import 'package:baswara_app/homeUser/domain/entities/catalog_entity.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/svg.dart';
import 'package:google_fonts/google_fonts.dart';

class CatalogItemWidget extends StatelessWidget {
  final CatalogData product;
  final int index;
  final VoidCallback edit;
  final VoidCallback delete;

  const CatalogItemWidget(
      {super.key,
      required this.product,
      required this.index,
      required this.edit,
      required this.delete});

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
              product.name,
              style: GoogleFonts.poppins(
                fontSize: 16,
              ),
            ),
          ),
          Expanded(
            flex: 2,
            child: Center(
                child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                InkWell(
                  onTap: edit,
                  child: SvgPicture.asset("assets/icons/icon_pencil.svg"),
                ),
                InkWell(
                  onTap: delete,
                  child: SvgPicture.asset(
                    "assets/icons/icon_trash.svg",
                    color: Colors.red,
                  ),
                )
              ],
            )),
          ),
        ],
      ),
    );
  }
}
