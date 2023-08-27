import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';

class AddProductDialog extends StatefulWidget {
  final BuildContext blocContext;

  const AddProductDialog({super.key, required this.blocContext});

  @override
  State<AddProductDialog> createState() => _AddProductDialogState();
}

class _AddProductDialogState extends State<AddProductDialog> {
  final TextEditingController _name = TextEditingController();
  final ValueNotifier<int> _category = ValueNotifier(1);
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            const SizedBox(
              height: 20,
            ),
            CustomFormWidget(
              obsecure: false,
              label: "Nama Sampah",
              controller: _name,
            ),
            const SizedBox(
              height: 36,
            ),
            DropdownButtonFormField<int>(
              decoration: InputDecoration(
                isDense: true,
                labelText: 'Kategori Sampah',
                labelStyle: GoogleFonts.poppins(fontSize: 16),
                border: const OutlineInputBorder(),
              ),
              items: [
                DropdownMenuItem(
                  value: 1,
                  child: Text('plastik',
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
                    'besi',
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
                    'tembaga',
                    style: GoogleFonts.poppins(
                      fontSize: 16,
                    ),
                  ),
                ),
                DropdownMenuItem(
                  value: 6,
                  child: Text(
                    'minyak',
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
                if (value != null) {
                  _category.value = value;
                }
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
                      if (_formKey.currentState!.validate()) {
                        widget.blocContext.read<AdminBloc>().add(AddProduct(
                              name: _name.text,
                              category: _category.value,
                            ));
                        Navigator.pop(context);
                      }
                    },
                    child: Container(
                      padding: const EdgeInsets.symmetric(vertical: 10),
                      decoration: BoxDecoration(
                          color: ColorValue.primary,
                          borderRadius: BorderRadius.circular(100)),
                      child: Center(
                        child: Text(
                          "Tambah",
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
      ),
    );
  }
}
