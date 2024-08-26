import 'package:flutter/material.dart';
import 'package:percent_indicator/percent_indicator.dart';

class TaskCompletionIndicator extends StatelessWidget {
  final double percentage; // Percentage should be between 0 and 100

  const TaskCompletionIndicator({
    super.key,
    required this.percentage,
  });

  @override
  Widget build(BuildContext context) {
    return CircularPercentIndicator(
      radius: 50.0,
      percent: percentage / 100,
      animation: true,
      lineWidth: 10.0,
      circularStrokeCap: CircularStrokeCap.round,
      center: Text(
        '${percentage.toStringAsFixed(0)}%',
        style: const TextStyle(
          fontSize: 18,
          fontWeight: FontWeight.bold,
          color: Colors.white,
        ),
      ),
      backgroundColor: Colors.white.withOpacity(0.5),
      progressColor: Colors.white,
    );
  }
}
