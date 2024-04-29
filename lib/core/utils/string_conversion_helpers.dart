// Convert firebase auth error codes to more user friendly format
String convertFirebaseAuthErrorCode(String errorCode) {
  // Replace hyphens with spaces
  return errorCode.replaceAll('-', ' ');
}