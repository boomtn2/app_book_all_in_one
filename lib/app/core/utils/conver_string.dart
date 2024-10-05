class ConvertString {
  //cắt chuỗi thành mảng ký tự <= max
  static List<String> splipMaxLenght(String st, int max) {
    st = st.replaceAll(RegExp(r'[^a-zA-ZÀ-ỹ0-9{1,}.!:?",]+'), ' ');
    List<String> segments = [];
    int indexSegment = -1;
    st.split(RegExp(r'(?<=[.?!"])')).forEach((element) {
      if (indexSegment == -1) {
        segments.add(element);
        indexSegment++;
      } else {
        String temp = "${segments[indexSegment]}\n$element";
        if (countWord(temp) <= max) {
          segments[indexSegment] = temp;
        } else {
          segments.add(element);
          indexSegment++;
        }
      }
    });

    return segments;
  }

  static int countWord(String st) {
    int count = st.trim().split(RegExp(r'\s+')).length;
    return count;
  }

  static String xoaKyTuDacBiet(String input) {
    String st = input.replaceAll(RegExp(r'[^a-zA-ZÀ-ỹ0-9{1,}.!:?",]+'), ' ');
    return st;
  }

  //Xử lý xóa các ký tự thừa
  static String xoakytudacbiet(String st) {
    st = st.replaceAll(RegExp(r'HȯṪȓuyëŋ.cøm', caseSensitive: false), ' ');
    st = st.replaceAll(
        RegExp(r'(Nguồn Hố Truyện hotruyen .com)', caseSensitive: false), ' ');
    st = st.trim();
    st = st.replaceAll('\n', '');
    st = st.replaceAll(RegExp(r'\.+'), '.\n');

    return st;
  }
}
