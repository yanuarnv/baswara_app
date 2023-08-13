import 'package:baswara_app/homeAdmin/domain/entities/category_entity.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

class CategoryItemWidget extends StatefulWidget {
  final DataCategory data;
  final List<TextEditingController> controller;

  const CategoryItemWidget({
    super.key,
    required this.data, required this.controller,
  });

  @override
  State<CategoryItemWidget> createState() => _CategoryItemWidgetState();
}

class _CategoryItemWidgetState extends State<CategoryItemWidget> {

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          widget.data.name,
          style: GoogleFonts.montserrat(
            fontSize: 16,
            fontWeight: FontWeight.w600,
          ),
        ),
        const SizedBox(
          height: 13,
        ),
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: List.generate(
            widget.data.products.length,
                (index) =>
                Padding(
                  padding: const EdgeInsets.only(bottom: 18.0),
                  child: Row(
                    children: [
                      Expanded(
                        flex: 3,
                        child: Text(
                          widget.data.products[index].name,
                          style: GoogleFonts.montserrat(
                            fontSize: 14,
                            fontWeight: FontWeight.w500,
                          ),
                        ),
                      ),
                      Expanded(
                        child: CustomFormWidget(
                          controller: widget.controller[index],
                          obsecure: false,
                          hint: "__",
                          textAlign: TextAlign.end,
                          contentPadding: const EdgeInsets.all(12),
                          inputType: TextInputType.number,
                          suffixIcon: Padding(
                            padding: const EdgeInsets.only(right: 8.0, left: 5),
                            child: Text(
                              "Kg",
                              style: GoogleFonts.montserrat(
                                fontSize: 14,
                                fontWeight: FontWeight.w500,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
          ),
        )
      ],
    );
  }
}
