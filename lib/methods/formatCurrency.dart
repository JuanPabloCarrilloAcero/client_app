import 'package:intl/intl.dart';

String formatCurrency(double value) {
  return NumberFormat.currency(
    symbol: '\$', // Optional if you want to specify the symbol manually
    decimalDigits: 2,
    locale: 'en_US', // Set the locale to en_US
  ).format(value);
}