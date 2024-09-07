class Util {
  static bool imageOk(String? value) {
    if (value == null || value.trim().isEmpty || !value.contains('http')) {
      return false;
    }
    return true;
  }
}
