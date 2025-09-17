import 'package:flutter/material.dart';
import 'package:minimart/src/app/startup/initializer.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializer();
}
