import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelling/views/main_screen.dart';
import 'views/first_screen.dart';

void main() {
  WidgetsFlutterBinding.ensureInitialized();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp.router(
        debugShowCheckedModeBanner: false,
        routerConfig: GoRouter(routes: [
      GoRoute(
        path: '/',
        builder: (context, state) => FirstScreen(),
        routes: [],
      ),
      GoRoute(
        path: '/MainScreen',
        builder: (context, state) => MainScreen(),
      )
    ]));
  }
}
