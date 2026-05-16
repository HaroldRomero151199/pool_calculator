import 'package:flutter/material.dart';

class CalculatorResult {
  final double cost;
  final String durationStr;

  CalculatorResult({required this.cost, required this.durationStr});
}

class CalculatorController {
  static CalculatorResult? calculate({
    required TimeOfDay? startTime,
    required TimeOfDay? endTime,
    required String priceText,
  }) {
    if (startTime == null || endTime == null || priceText.isEmpty) {
      return null;
    }

    double pricePerHour = double.tryParse(priceText) ?? 0.0;

    DateTime now = DateTime.now();
    DateTime startDateTime = DateTime(
        now.year, now.month, now.day, startTime.hour, startTime.minute);
    DateTime endDateTime =
        DateTime(now.year, now.month, now.day, endTime.hour, endTime.minute);

    if (endDateTime.isBefore(startDateTime)) {
      endDateTime = endDateTime.add(const Duration(days: 1));
    }

    Duration difference = endDateTime.difference(startDateTime);
    double hours = difference.inMinutes / 60.0;
    double cost = hours * pricePerHour;

    int hrs = difference.inHours;
    int mins = difference.inMinutes.remainder(60);
    String durationStr = "";
    if (hrs > 0) durationStr += "$hrs Horas ";
    if (mins > 0) durationStr += "$mins min";
    if (hrs == 0 && mins == 0) durationStr = "0 min";

    return CalculatorResult(cost: cost, durationStr: durationStr.trim());
  }
}
