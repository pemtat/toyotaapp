String extractDescription(String description) {
  final indexCD = description.indexOf('(');
  final indexDash = description.indexOf('-');

  int endIndex;
  if (indexCD != -1 && (indexDash == -1 || indexCD < indexDash)) {
    endIndex = indexCD;
  } else if (indexDash != -1) {
    endIndex = indexDash;
  } else {
    endIndex = description.length;
  }

  return description.substring(0, endIndex);
}
