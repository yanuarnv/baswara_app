import 'package:flutter/services.dart';

class RegexInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    final unformattedText =
        newValue.text.replaceAll(RegExp(r'^(\d+)?\.?\d{0,2}'), '');

    return TextEditingValue(
      text: unformattedText,
      selection: TextSelection.collapsed(offset: unformattedText.length),
    );
  }
}
