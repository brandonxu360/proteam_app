// Convert firebase auth error codes to more user friendly format
String convertFirebaseAuthErrorCode(String errorCode) {
  // Replace hyphens with spaces
  return errorCode.replaceAll('-', ' ');
}

// Convert strings to pascal case
// Used primarily in the parsing of the food json data
String formatPascalCase(String input) {
  return input
      .toLowerCase()
      .split(' ')
      .map((word) =>
          word.isNotEmpty ? '${word[0].toUpperCase()}${word.substring(1)}' : '')
      .join(' ');
}
