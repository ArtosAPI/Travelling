import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelling/firebase/firebase_cruds.dart';
import 'package:travelling/firebase/firebase_options.dart';
import 'package:travelling/models/profile_settings.dart';
import 'package:travelling/views/pages/main_screen.dart';
import 'package:travelling/views/pages/sign_in_screen.dart';
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
            builder: (context, state) => MainScreen(),
          ),
          GoRoute(
            path: '/SignInPage',
            builder: (context, state) => SignInPage(),
          )
        ]));
  }
}
