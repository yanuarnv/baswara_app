import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IDRInputFormatter extends TextInputFormatter {
  final bool userSymbol;

  IDRInputFormatter({this.userSymbol = true});

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final NumberFormat currencyFormatter = NumberFormat.currency(
      symbol: userSymbol ? 'IDR ' : "",
      decimalDigits: 0,
    );
    if (newValue.text.isNotEmpty) {
      final unformattedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
      final formattedText =
          currencyFormatter.format(int.parse(unformattedText));

      return TextEditingValue(
        text: formattedText,
        selection: TextSelection.collapsed(offset: formattedText.length),
      );
    } else {
      return const TextEditingValue();
    }
  }
}
