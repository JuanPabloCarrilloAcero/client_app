import 'package:flutter/services.dart';

class ThousandsSeparatorInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(text: '');
    }

    final int newValueInt = int.tryParse(newValue.text.replaceAll(',', '')) ?? 0;
    final String newFormattedValue = newValueInt.toString().replaceAllMapped(
      RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))'),
          (Match match) => '${match[1]},',
    );

    return newValue.copyWith(
      text: newFormattedValue,
      selection: TextSelection.collapsed(offset: newFormattedValue.length),
    );
  }
}