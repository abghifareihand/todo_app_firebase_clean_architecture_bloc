import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

extension DateExt on DateTime {
  String toFormattedDate() {
    return DateFormat('dd/MM/yyyy').format(this);
  }
}

extension TimeOExt on TimeOfDay {
  String toFormattedTime() {
    String hourTime = hour.toString().padLeft(2, '0');
    String minuteTime = minute.toString().padLeft(2, '0');
    return '$hourTime:$minuteTime';
  }
}

extension DateTimeExt on DateTime {
  String toFormattedDateTime() {
    return DateFormat('dd-MM-yyyy HH:mm').format(this);
  }
}
