import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:go_router/go_router.dart';
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
  bool agreedWithPolicement = false;
  final _key = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      extendBodyBehindAppBar: true,
      body: Padding(
        padding: const EdgeInsets.all(25),
        child: Form(
          key: _key,
          child: ListView(
            children: [
              Align(
                alignment: Alignment.center,
                child: Column(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.all(Radius.circular(75)),
                      child: Container(
                        width: 125,
                        height: 125,
                        decoration: const BoxDecoration(
                            gradient: LinearGradient(
                                begin: Alignment.topLeft,
                                end: Alignment.bottomRight,
                                colors: [
                                  Color.fromRGBO(20, 125, 219, 1),
                                  Color.fromRGBO(20, 115, 202, 1),
                                  Color.fromRGBO(20, 105, 196, 1),
                                  Color.fromRGBO(20, 95, 165, 1),
                                  Color.fromRGBO(20, 75, 168, 1),
                                ]),
                            image: DecorationImage(
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
                height: 55,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text('Sign in to Treavelling',
                      style: Texts.instance.textStyle1
                          .copyWith(fontWeight: FontWeight.bold))),
              const SizedBox(
                height: 25,
              ),
              TextFormField(
                keyboardType: TextInputType.emailAddress,
                decoration: InputDecoration(
                    labelText: 'Email', labelStyle: Texts.instance.textStyle2),
                onChanged: (value) => setState(() {
                  email = value;
                  _key.currentState!.validate();
                }),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your email';
                  }
                  if (!(value.contains('@'))) {
                    return 'Enter valid email adress!';
                  }
                },
              ),
              TextFormField(
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: 'Password',
                    labelStyle: Texts.instance.textStyle2),
                onChanged: (value) => setState(
                  () {
                    password = value;
                    _key.currentState!.validate();
                  },
                ),
                validator: (value) {
                  if (value == null || value.isEmpty) {
                    return 'Enter your password';
                  }
                  if (value.length <= 6) {
                    return 'Password should be at least 6 chars long';
                  }
                },
              ),
              SizedBox(
                height: 6,
              ),
              Row(
                children: [
                  Checkbox(
                    value: agreedWithPolicement,
                    onChanged: (agreed) {
                      setState(() {
                        agreedWithPolicement = !agreedWithPolicement;
                      });
                    },
                    materialTapTargetSize: MaterialTapTargetSize.shrinkWrap,
                  ),
                  Text('Agree with policement'),
                  Spacer(),
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
              SizedBox(
                height: 15,
              ),
              Column(
                children: [
                  GestureDetector(
                      onTap: () async {
                        final shouldSignIn = _key.currentState!.validate();
                        if (shouldSignIn) {
                          try {
                            await showDialog(
                                context: context,
                                builder: (context) {
                                  return FutureBuilder(
                                      future: FirebaseUser.init(
                                              email!, password!)
                                          .then((value) =>
                                              AvatarImage.initialAvatarImage()),
                                      builder: (context, AsyncSnapshot snap) {
                                        if (snap.connectionState ==
                                            ConnectionState.done) {
                                          Navigator.pop(context);
                                        }
                                        return Center(
                                          child: Container(
                                              width: 100,
                                              height: 100,
                                              color: Colors.white,
                                              alignment: Alignment.center,
                                              child:
                                                  CircularProgressIndicator()),
                                        );
                                      });
                                });

                            context.go('/MainScreen');
                          } catch (e) {}
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
                              Colors.blue[300] as Color,
                              Colors.blue[400] as Color
                            ])),
                        child: const Text(
                          'Sign in',
                        ),
                      )),
                  SizedBox(
                    height: 6,
                  ),
                  GestureDetector(child: Text('Or Sign up')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
