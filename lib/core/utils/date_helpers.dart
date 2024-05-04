import 'package:intl/intl.dart';

// Long date format or full date format (ie. Monday, Jan 23)
String formatDateLDF(DateTime date) {
  final DateFormat formatter = DateFormat('EEEE, MMM d');
  return formatter.format(date);
}

// Month day year format (ie. 02/13/2002)
String formatDateMDY(DateTime date) {
  final DateFormat formatter = DateFormat('MM/dd/yyyy');
  return formatter.format(date);
}

// Replace the slashes, which are special characters for firestore, with dashes
String encodeDateForFirestore(String date) {
  // Encode the date in a format suitable for Firestore document ID
  return date.replaceAll('/', '-'); // Replace slashes with dashes
}

// Replace the dashes with slashes for readability when presenting to the user
String decodeDateFromFirestore(String encodedDate) {
  // Decode the Firestore document ID back into date format
  return encodedDate.replaceAll('-', '/'); // Replace dashes with slashes
}

// Return the day of the year (out of 365)
int dayOfYear(DateTime date) {
  // Create a DateTime object for the start of the year
  DateTime startOfYear = DateTime(date.year, 1, 1);

  // Calculate the difference between the given date and the start of the year
  Duration difference = date.difference(startOfYear);

  // Return the number of days in the difference
  return difference.inDays + 1; // Add 1 because difference is zero-based
}