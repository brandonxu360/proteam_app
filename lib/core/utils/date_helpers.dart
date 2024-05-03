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
