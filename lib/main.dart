import 'package:flutter/material.dart';
import 'package:travelling/views/main_screen.dart';
import 'views/first_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MaterialApp(home: MyApp()));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MainScreen();
  }
}
