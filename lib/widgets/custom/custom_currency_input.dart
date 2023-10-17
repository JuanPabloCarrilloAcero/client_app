import 'package:flutter/services.dart';

class CurrencyInputFormatter extends TextInputFormatter {
  @override
  TextEditingValue formatEditUpdate(
      TextEditingValue oldValue, TextEditingValue newValue) {
    if (newValue.text.isEmpty) {
      return newValue.copyWith(
        text: '0.00',
      );
    }

    final numericString = newValue.text.replaceAll(RegExp(r'[^\d]'), '');

    if (numericString.isEmpty) {
      return newValue.copyWith(
        text: '0.00',
        selection: TextSelection.collapsed(offset: 4),
      );
    }

    final intValue = int.parse(numericString);
    final double doubleValue = intValue / 100.0;
    final formattedValue = '\$${doubleValue.toStringAsFixed(2)}';

    final parts = formattedValue.split('.');
    final wholePart = parts[0];
    final decimalPart = parts[1];

    final thousandsRegExp = RegExp(r'(\d{1,3})(?=(\d{3})+(?!\d))');
    final formattedWholePart =
    wholePart.replaceAllMapped(thousandsRegExp, (Match match) => '${match[1]},');

    final newText = '$formattedWholePart.$decimalPart';
    return newValue.copyWith(
      text: newText,
      selection: TextSelection.collapsed(offset: newText.length),
    );
  }
}