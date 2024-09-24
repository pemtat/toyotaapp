String extractDescription(String description) {
  final indexCD = description.indexOf('(');
  final indexDash = description.indexOf('-');
  final indexDot = description.indexOf('.');

  int endIndex;

  if (indexCD != -1 &&
      (indexDash == -1 || indexCD < indexDash) &&
      (indexDot == -1 || indexCD < indexDot)) {
    endIndex = indexCD;
  } else if (indexDash != -1 && (indexDot == -1 || indexDash < indexDot)) {
    endIndex = indexDash;
  } else if (indexDot != -1) {
    endIndex = indexDot;
  } else {
    endIndex = description.length;
  }

  return description.substring(0, endIndex);
}
