import 'package:flutter/material.dart';
import 'package:minimart/src/app/presentation/page/splash.dart';

class MiniMart extends StatelessWidget {
  const MiniMart({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'MiniMart',
      debugShowCheckedModeBanner: false,
      home: Splash(),
    );
  }
}
