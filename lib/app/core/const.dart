import 'package:logger/logger.dart';

import 'values/app_values.dart';

class Const {
  static bool isDebug = true;
  static String baseUrl = '';
  static Logger logger = Logger(
    printer: PrettyPrinter(
      methodCount: AppValues.loggerMethodCount,
      // number of method calls to be displayed
      errorMethodCount: AppValues.loggerErrorMethodCount,
      // number of method calls if stacktrace is provided
      lineLength: AppValues.loggerLineLength,
      // width of the output
      colors: true,
      // Colorful log messages
      printEmojis: true,
      // Print an emoji for each log message
    ),
  );

  static String typePlayList = 'youtube#playlist';
  static String typeVideo = 'youtube#video';
  static String typeMP3 = 'mp3';
  static String typeText = 'text';
}
