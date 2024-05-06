import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelling/firebase/firebase_cruds.dart';
import 'package:travelling/models/profile_settings.dart';
import 'package:travelling/utils/texts.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({super.key});

  @override
  State<SignUpPage> createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  String? email, password, name;
  bool agreedWithPolicement = false;
  final _emailKey = GlobalKey<FormFieldState>();
  final _passwordKey = GlobalKey<FormFieldState>();
  final _nameKey = GlobalKey<FormFieldState>();

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
                height: 55,
              ),
              Align(
                  alignment: Alignment.center,
                  child: Text('Sign up to Travelling',
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
              TextFormField(
                key: _nameKey,
                keyboardType: TextInputType.visiblePassword,
                decoration: InputDecoration(
                    labelText: 'Name', labelStyle: Texts.instance.textStyle2),
                onChanged: (value) => setState(
                  () {
                    name = value;
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
                  const Text('Agree with policement'),
                  const Spacer(),
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
                        _nameKey.currentState!.validate();
                        final correctCreds =
                            _emailKey.currentState!.validate() &&
                                _passwordKey.currentState!.validate() &&
                                _nameKey.currentState!.validate();
                        if (correctCreds) {
                          if (!agreedWithPolicement) {
                            ScaffoldMessenger.of(context)
                                .showSnackBar(const SnackBar(
                              content: Text('You should agree with policy'),
                            ));
                          } else {
                            await showDialog(
                                context: context,
                                builder: (_) {
                                  email = email!.trim();
                                  password = password!.trim();
                                  try {
                                    return FutureBuilder(
                                        future: Future.wait([
                                          FirebaseUser.signUp(
                                              email!, name!, password!, []),
                                          AvatarImage.initialAvatarImage()
                                        ]),
                                        builder: (_, AsyncSnapshot snap) {
                                          if (snap.connectionState ==
                                              ConnectionState.done) {
                                            if (snap.data[0] == true) {
                                              Navigator.pop(context);
                                              //without delayed operation for some
                                              //time, there will be an error!
                                              Future.delayed(Duration.zero, () {
                                                context.go('/MainScreen');
                                              });
                                            } else {
                                              //TODO: add more exception info!
                                              Navigator.pop(context);
                                              Future.delayed(Duration.zero, () {
                                                ScaffoldMessenger.of(context)
                                                    .showSnackBar(
                                                        const SnackBar(
                                                  content:
                                                      Text('No person found'),
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
                                  } catch (e) {
                                    return Container();
                                  }
                                });
                          }
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
                          'Sign up',
                        ),
                      )),
                  const SizedBox(
                    height: 6,
                  ),
                  GestureDetector(
                      onTap: () {
                        context.go("/SignInPage");
                      },
                      child: const Text('Or Sign in')),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
