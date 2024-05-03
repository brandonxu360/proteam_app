// Checks if the value is null or empty
bool notEmptyCheck(value) {
  if (value == null || value.isEmpty) {
    return false;
  }
  return true;
}

// Checks if the value is a valid positive integer
bool positiveDoubleCheck(value) {
  double? parsedValue = double.tryParse(value);
  if (parsedValue == null || parsedValue < 0) {
    return false;
  }
  return true;
}