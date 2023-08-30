import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/domain/entities/product_entity.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class EditProductDialog extends StatefulWidget {
  final BuildContext blocContext;
  final Product model;

  const EditProductDialog(
      {super.key, required this.blocContext, required this.model});

  @override
  State<EditProductDialog> createState() => _EditProductDialogState();
}

class _EditProductDialogState extends State<EditProductDialog> {
  final TextEditingController name = TextEditingController();
  int categoryId = 0;

  @override
  void initState() {
    // TODO: implement initState
    name.text = widget.model.name;
    categoryId = widget.model.categoriesId.id;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const SizedBox(
            height: 20,
          ),
          CustomFormWidget(
            obsecure: false,
            label: "Nama Sampah",
            controller: name,
          ),
          const SizedBox(
            height: 36,
          ),
          DropdownButtonFormField<int>(
            value: categoryId,
            decoration: InputDecoration(
              isDense: true,
              labelText: 'Kategori Sampah',
              labelStyle: GoogleFonts.poppins(fontSize: 16),
              border: const OutlineInputBorder(),
            ),
            items: [
              DropdownMenuItem(
                value: 1,
                child: Text('Plastik',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    )),
              ),
              DropdownMenuItem(
                value: 2,
                child: Text('kertas',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    )),
              ),
              DropdownMenuItem(
                value: 3,
                child: Text(
                  'Minyak',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 4,
                child: Text(
                  'kaca',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 5,
                child: Text(
                  'Besi',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 6,
                child: Text(
                  'Tembaga',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
              DropdownMenuItem(
                value: 7,
                child: Text(
                  'lainnya',
                  style: GoogleFonts.poppins(
                    fontSize: 16,
                  ),
                ),
              ),
              // Add more items as needed
            ],
            onChanged: (value) {
              setState(() {
                categoryId = value!;
              });
            },
          ),
          const SizedBox(
            height: 30,
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
                        "Batal",
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
                    widget.blocContext.read<AdminBloc>().add(EditProduct(
                        widget.model.id.toString(),
                        name.text,
                        categoryId.toString()));
                    Navigator.pop(context);
                  },
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
              ),
            ],
          )
        ],
      ),
    );
  }
}
