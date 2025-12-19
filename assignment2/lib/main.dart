import 'package:flutter/material.dart';
import 'home_screen.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'أصوات الحيوانات',
      theme: ThemeData(
        primarySwatch: Colors.green,
        fontFamily: 'Cairo', // يمكنك استخدام خط عربي
      ),
      home: const HomeScreen(),
      debugShowCheckedModeBanner: false,
    );
  }
}