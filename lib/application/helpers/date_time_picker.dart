import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

class DateTimePicker {
  static Future<String> showingDatePicker(BuildContext context) async {
    DateTime selectedDate = DateTime.now();
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate,
      firstDate: DateTime(1900),
      lastDate: DateTime(2101),
    );

    return DateFormat('dd MMMM yyyy', 'id').format(picked ?? selectedDate);
  }
}
