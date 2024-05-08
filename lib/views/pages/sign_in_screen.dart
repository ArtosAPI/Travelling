import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelling/Shared_Prefs/shared_prefs.dart';
import 'package:travelling/firebase/firebase_cruds.dart';
import 'package:travelling/models/profile_settings.dart';
import 'package:travelling/utils/texts.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({super.key});

  @override
  State<SignInPage> createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  String? email, password;
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();

  @override
  void initState() {
    try {
      Map<String, dynamic>? data;
      setState(() {
        Future.delayed(Duration.zero, () async {
          data = await Shared.getData();

          if (data!.values.every((element) {
            if (element is String) {
              return element.isNotEmpty;
            } else {
              return true;
            }
          })) {
            email = data!['email'];
            password = data!['password'];

            await FirebaseUser.signIn(email!, password!);
            await AvatarImage.initialAvatarImage();

            FirebaseUser.ins?.name = data!['name'];
            FirebaseUser.ins?.likedCards = data!['likedCards'];

            context.go('/MainScreen');
          }
        });
      });
    } catch (e) {}

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: const BorderRadius.all(Radius.circular(75)),
                      child: Container(
                        width: 125,
                        height: 125,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Colors.lightBlue[300] as Color,
                                  Colors.lightBlue[400] as Color,
                                  Colors.lightBlue,
                                  Colors.lightBlue[500] as Color,
                                  Colors.lightBlue[600] as Color,
                                  Colors.lightBlue[700] as Color,
                                ]),
                            image: const DecorationImage(
                                image: AssetImage(
                                    'assets/mipmap-xxxhdpi/ic_launcher_adaptive_fore.png'),
                                fit: BoxFit.cover)),
                      ),
                    ),
                    Text('Travel',
                        style: Texts.instance.header
                            .copyWith(fontSize: 25, color: Colors.black)),
                  ],
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text('Sign in',
                      style: Texts.instance.textStyle1
                          .copyWith(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                key: _emailKey,
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email', labelStyle: Texts.instance.textStyle2),
                onChanged: (value) => setState(() {
                  email = value;
                  _emailKey.currentState!.validate();
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email';
                  }
                  if (!(value.contains('@'))) {
                    return 'Enter valid email adress!';
                  }
                  return null;
                },
              ),
              TextFormField(
                key: _passwordKey,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Texts.instance.textStyle2),
                onChanged: (value) => setState(
                  () {
                    password = value;
                    _passwordKey.currentState!.validate();
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your password';
                  }
                  return null;
                },
              ),
              const SizedBox(
                height: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  GestureDetector(
                      child: Align(
                          alignment: Alignment.centerRight,
                          child: Text('Forgot password',
                              style: Texts.instance.textStyle2.copyWith(
                                  color: Colors.grey[600],
                                  decoration: TextDecoration.underline,
                                  decorationStyle: TextDecorationStyle.wavy,
                                  decorationColor: Colors.grey[600])))),
                ],
              ),
              const SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        _emailKey.currentState!.validate();
                        _passwordKey.currentState!.validate();
                        final shouldSignIn =
                            _emailKey.currentState!.validate() &&
                                _passwordKey.currentState!.validate();
                        if (shouldSignIn) {
                          await showDialog(
                              context: context,
                              builder: (_) {
                                email = email!.trim();
                                password = password!.trim();
                                try {
                                  return FutureBuilder(
                                      future: Future.wait([
                                        FirebaseUser.signIn(email!, password!),
                                        AvatarImage.initialAvatarImage()
                                      ]),
                                      builder: (_, AsyncSnapshot snap) {
                                        if (snap.connectionState ==
                                            ConnectionState.done) {
                                          if (snap.data[0] == 'true') {
                                            Navigator.pop(context);
                                            //without delayed operation for some
                                            //time, there will be an error!

                                            try {
                                              Shared.setData({
                                                'email': email,
                                                'password': password,
                                                'name': FirebaseUser.ins!.name,
                                                'likedCards': FirebaseUser.ins!
                                                    .likedCards as List<String>
                                              });
                                            } catch (e) {}

                                            Future.delayed(Duration.zero, () {
                                              context.go('/MainScreen');
                                            });
                                          } else {
                                            Navigator.pop(context);
                                            Future.delayed(Duration.zero, () {
                                              ScaffoldMessenger.of(context)
                                                  .showSnackBar(SnackBar(
                                                content: Text(snap.data[0]),
                                              ));
                                            });
                                          }
                                        }
                                        return Center(
                                          child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.white,
                                              alignment: Alignment.center,
                                              child:
                                                  const CircularProgressIndicator()),
                                        );
                                      });
                                } on FirebaseException {
                                  return Container();
                                }
                              });
                        }
                      },
                      child: Container(
                        height: 35,
                        margin: const EdgeInsets.symmetric(horizontal: 50),
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topCenter,
                                end: Alignment.bottomCenter,
                                colors: [
                              Colors.lightBlue[400] as Color,
                              Colors.lightBlue,
                              Colors.lightBlue[500] as Color,
                            ])),
                        child: const Text(
                          'Sign in',
                        ),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                      onTap: () {
                        context.go("/SignUpPage");
                      },
                      child: const Text('Or Sign up')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
