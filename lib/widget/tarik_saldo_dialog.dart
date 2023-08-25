import 'package:baswara_app/core/color_value.dart';
import 'package:baswara_app/homeAdmin/presentation/manager/admin_bloc.dart';
import 'package:baswara_app/homeUser/domain/entities/home_user_entity.dart';
import 'package:baswara_app/widget/custom_form_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:intl/intl.dart';

class TarikSaldoDialog extends StatefulWidget {
  final BuildContext blocContext;
  final Data user;

  const TarikSaldoDialog(
      {super.key, required this.blocContext, required this.user});

  @override
  State<TarikSaldoDialog> createState() => _TarikSaldoDialogState();
}

class _TarikSaldoDialogState extends State<TarikSaldoDialog> {
  final _formKey = GlobalKey<FormState>();
  final _nominal = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return AlertDialog(
      content: Form(
        key: _formKey,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          mainAxisSize: MainAxisSize.min,
          children: [
            GestureDetector(
              onTap: () {
                Navigator.pop(context);
              },
              child: const Align(
                alignment: Alignment.centerRight,
                child: Icon(Icons.close),
              ),
            ),
            Text(
              "Total Saldo",
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              NumberFormat.currency(
                      locale: 'id', symbol: 'Rp ', decimalDigits: 2)
                  .format(int.parse(widget.user.savings)),
              style: GoogleFonts.poppins(
                fontWeight: FontWeight.w500,
                fontSize: 16,
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            CustomFormWidget(
              obsecure: false,
              label: "Tarik Saldo",
              hint: "Jumlah Yang Ingin Ditarik",
              controller: _nominal,
              inputType: TextInputType.number,
              inputFormaters: [FilteringTextInputFormatter.digitsOnly],
              validation: (value) {
                if (value == null || value.isEmpty) {
                  return 'Silahkan Masukan Nominal';
                }
                if (int.parse(value) > int.parse(widget.user.savings)) {
                  return 'nominal lebih dari saldo';
                }
                return null;
              },
            ),
            const SizedBox(
              height: 26,
            ),
            GestureDetector(
              onTap: () {
                if (_formKey.currentState!.validate()) {
                  widget.blocContext.read<AdminBloc>().add(
                        TarikSaldoUser(
                          widget.user.id,
                          int.parse(_nominal.text),
                        ),
                      );
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
            )
          ],
        ),
      ),
    );
  }
}
