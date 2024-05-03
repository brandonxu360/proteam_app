import 'package:flutter/material.dart';
import 'package:proteam_app/features/log/presentation/widgets/day_log_view.dart';

// Main page to display the overview of the food logs
class LogPage extends StatelessWidget {
  const LogPage({super.key});

  @override
  Widget build(BuildContext context) {
    return DayLogView();
  }
}
