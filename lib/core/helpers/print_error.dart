
import 'package:flutter/foundation.dart';
class PrintError {

  static void makePrint({
    required Object e,
    StackTrace? stack, 
    required String ubication
  }) {
    final currentTime = DateTime.now();
    final String formatTime = "${currentTime.day}/${currentTime.month}/${currentTime.day} ${currentTime.hour}:${currentTime.minute}:${currentTime.second}";
    if (kDebugMode) {
      print(">>> ERROR: Time: $formatTime, Ubication: $ubication, Type error: ${e.runtimeType}, Error: $e");
      if (stack != null) {
        print(">>> ERROR STACK: $stack");
      }
    }
  }
}
