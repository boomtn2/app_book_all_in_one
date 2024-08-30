extension GetNullIndexList on List {
  getNullIndex(int index) {
    if (index >= length) {
      return null;
    } else {
      return this[index];
    }
  }
}
