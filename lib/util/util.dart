bool isNumeric(String s) {
  if (s.isEmpty) {
    return false;
  }
  return num.tryParse(s) != null;
}
