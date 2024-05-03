import 'package:intl/intl.dart';

String formatDate(DateTime date) {
  final DateFormat formatter = DateFormat('EEEE, MMM d');
  return formatter.format(date);
}