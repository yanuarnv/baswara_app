import 'package:flutter/services.dart';
import 'package:intl/intl.dart';

class IDRInputFormatter extends TextInputFormatter {
  final NumberFormat _currencyFormatter = NumberFormat.currency(
    symbol: 'IDR ',
    decimalDigits: 0,
  );

  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final unformattedText = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');
    final formattedText = _currencyFormatter.format(int.parse(unformattedText));

    return TextEditingValue(
      text: formattedText,
      selection: TextSelection.collapsed(offset: formattedText.length),
    );
  }
}
