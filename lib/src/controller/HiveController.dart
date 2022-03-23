import 'package:hive_flutter/hive_flutter.dart';
import 'package:pontuador/src/controller/TimeStampController.dart';

class HiveController {
  static Future<void> init() async {
    await Hive.initFlutter();
    var timeStampController = TimeStampController.init();
    await timeStampController;
  }
}