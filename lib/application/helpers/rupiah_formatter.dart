import 'package:intl/intl.dart';

final formatter = NumberFormat('#,###', 'id_ID');

class RupiahFormatter {
  static String format(
    value, {
    String separator = '.',
    String trailing = '',
  }) {
    return 'Rp. ${formatter.format(double.parse(value.toString()))}';
  }

  static String formatWithOutRp(
    value, {
    String separator = '.',
    String trailing = '',
  }) {
    return formatter.format(double.parse(value.toString()));
  }
}
