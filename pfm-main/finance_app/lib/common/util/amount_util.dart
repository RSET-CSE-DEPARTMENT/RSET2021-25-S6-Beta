import 'package:intl/intl.dart';

String getAmountString(double num) {
  var formattedNumber = NumberFormat.compact().format(num);
  return formattedNumber;
}
