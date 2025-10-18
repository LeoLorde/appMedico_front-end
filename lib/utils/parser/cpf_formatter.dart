import 'package:flutter/services.dart';

class CpfInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    String digitsOnly = newValue.text.replaceAll(RegExp(r'[^0-9]'), '');

    if (digitsOnly.length > 11) {
      digitsOnly = digitsOnly.substring(0, 11);
    }

    String formatted = '';
    int index = 0;

    for (var i = 0; i < digitsOnly.length; i++) {
      formatted += digitsOnly[i];
      index++;

      if (index == 3 || index == 6) {
        if (index != digitsOnly.length) {
          formatted += '.';
        }
      } else if (index == 9) {
        if (index != digitsOnly.length) {
          formatted += '-';
        }
      }
    }
    return TextEditingValue(
      text: formatted,
      selection: TextSelection.collapsed(offset: formatted.length),
    );
  }
}
