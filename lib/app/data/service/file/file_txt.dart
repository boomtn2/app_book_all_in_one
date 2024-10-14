import 'dart:io'; // Thư viện để làm việc với file
import 'package:flutter/widgets.dart';
import 'package:path_provider/path_provider.dart'; // Để lấy đường dẫn lưu file

class FileTXT {
  String? _filePath; // Biến lưu đường dẫn

  // Hàm lấy đường dẫn file (chỉ khởi tạo một lần)
  Future<String> _getFilePath() async {
    if (_filePath == null) {
      final directory = await getApplicationDocumentsDirectory();
      _filePath = '${directory.path}/history.txt'; // Đường dẫn file .txt
    }
    return _filePath!;
  }

  // Hàm ghi dữ liệu ra file
  Future<void> writeDataToFile(String data) async {
    try {
      final path = await _getFilePath(); // Lấy đường dẫn file một lần
      final file = File(path);

      // Ghi dữ liệu ra file, sử dụng FileMode.write để ghi đè
      await file.writeAsString(data, mode: FileMode.write);
    } catch (e) {
      debugPrint("[ERROR] [FileTXT] \n$e");
    }
  }

  // Hàm đọc dữ liệu từ file
  Future<String> readDataFromFile() async {
    try {
      final path = await _getFilePath(); // Lấy đường dẫn file
      final file = File(path);

      // Kiểm tra nếu file tồn tại
      if (await file.exists()) {
        // Đọc dữ liệu từ file và trả về dưới dạng chuỗi
        String fileContents = await file.readAsString();
        return fileContents;
      } else {
        return 'File không tồn tại!';
      }
    } catch (e) {
      return 'Lỗi khi đọc file: $e';
    }
  }
}
