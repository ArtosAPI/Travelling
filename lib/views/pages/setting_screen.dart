import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelling/Shared_Prefs/shared_prefs.dart';

class SettingsPage extends StatelessWidget {
  const SettingsPage({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Align(
            child: TextButton(
          onPressed: () async {
            await FirebaseAuth.instance.signOut();
            Shared.removeData();
            context.go("/SignInPage");
          },
          child: const Text('Sign out'),
        )),
      ),
    );
  }
}
