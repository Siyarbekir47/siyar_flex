import 'package:flutter/material.dart';
import 'package:siyar_flex/screens/home/home.dart';
import 'package:siyar_flex/screens/video_link_screens.dart';
import 'package:siyar_flex/shared/scraper_service.dart';

void main() {
  runApp(const MainApp());
}

class MainApp extends StatelessWidget {
  const MainApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'SiyarFlix',
      theme: ThemeData(
        useMaterial3: true,
        colorScheme: ColorScheme.fromSeed(seedColor: Colors.deepOrange),
      ),
      home: Home(),
    );
  }
}
