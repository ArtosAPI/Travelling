import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelling/firebase/firebase_options.dart';
import 'package:travelling/views/pages/main_screen.dart';
import 'package:travelling/views/pages/setting_screen.dart';
import 'package:travelling/views/pages/sign_in_screen.dart';
import 'package:travelling/views/pages/sign_up_screen.dart';
import 'views/pages/splash_screen.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();

  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );

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
            builder: (context, state) => const SplashScreen(),
          ),
          GoRoute(
            path: '/MainScreen',
            builder: (context, state) => const MainScreen(),
          ),
          GoRoute(
            path: '/SignInPage',
            builder: (context, state) => const SignInPage(),
          ),
          GoRoute(
            path: '/SignUpPage',
            builder: (context, state) => const SignUpPage(),
          ),
          GoRoute(
            path: '/SettingsPage',
            builder: (context, state) => const SettingsPage(),
          )
        ]));
  }
}
