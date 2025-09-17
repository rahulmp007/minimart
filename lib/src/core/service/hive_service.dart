import 'dart:developer';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:path_provider/path_provider.dart';
import '../../features/auth/data/models/user_model.dart'; // example model

class HiveService {
  Future<void> init() async {
    try {
      final dir = await getApplicationDocumentsDirectory();
      await Hive.initFlutter(dir.path);
    } on Exception catch (e) {
      log('hive init error: $e');
    }

    /// registering adapters
    Hive.registerAdapter(UserModelAdapter());
  }
}
