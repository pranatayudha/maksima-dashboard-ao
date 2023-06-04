import 'package:intl/intl.dart';

class DateStringFormatter {
  static String forOutput(String dateString) {
    final inputFormat = DateFormat('dd/MM/yyyy');
    final date = inputFormat.parse(dateString);
    final outputFormat = DateFormat('yyyy-MM-dd', 'id');

    return outputFormat.format(date);
  }

  static String forInput(String dateString) {
    final inputFormat = DateFormat('dd/MM/yyyy', 'id');
    final date = DateTime.parse(dateString);

    return inputFormat.format(date);
  }

  static String forOutputRitel(String dateString) {
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final date = inputFormat.parse(dateString);
    final outputFormat = DateFormat('dd MMMM yyyy', 'id');

    return outputFormat.format(date);
  }

  static String forOutputRitelKTPTerbit(String dateString) {
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final date = inputFormat.parse(dateString);
    final outputFormat = DateFormat('dd/MM/yyyy', 'id');

    return outputFormat.format(date);
  }

  static String forPrakarsaDate(String dateString) {
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final date = inputFormat.parse(dateString);
    final outputFormat = DateFormat('dd MMM yyyy', 'id');

    return outputFormat.format(date);
  }

  static String forOutputDate(String dateString) {
    final inputFormat = DateFormat('dd/MM/yyyy', 'id');
    final date = inputFormat.parse(dateString);
    final outputFormat = DateFormat('dd MMMM yyyy', 'id');

    return outputFormat.format(date);
  }

  static String forInputDate(String dateString) {
    final inputFormat = DateFormat('dd MMMM yyyy', 'id');
    final date = inputFormat.parse(dateString);
    final outputFormat = DateFormat('dd/MM/yyyy', 'id');

    return outputFormat.format(date);
  }

  static String forDetailPrakarsaDate(String dateString) {
    final inputFormat = DateFormat('yyyy-MM-ddTHH:mm:ssZ');
    final date = inputFormat.parse(dateString);
    final outputFormat = DateFormat('dd MMMM yyyy', 'id');

    return outputFormat.format(date);
  }
}
