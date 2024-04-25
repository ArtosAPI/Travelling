import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling/firebase_cruds.dart';
import 'package:travelling/models/profile_settings.dart';
import 'package:travelling/utils/texts.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
      extendBody: true,
      extendBodyBehindAppBar: true,
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        actions: [
          IconButton(
              onPressed: () {},
              icon: const Icon(
                Icons.settings,
                size: 25,
              )),
          const SizedBox(
            width: 22,
          )
        ],
      ),
      body: ChangeNotifierProvider(
        create: (context) => ProfileSettings(),
        child: Consumer(builder: (context, ProfileSettings settings, child) {
          settings.initialAvatarImage();
          return ListView(
            padding: EdgeInsets.all(25),
            children: [
              GestureDetector(
                onDoubleTap: () {
                  settings.setAvatarImage();
                },
                child: CircleAvatar(
                  backgroundImage: settings.image != null
                      ? MemoryImage(settings.image!)
                      : null,
                  maxRadius: width / 3,
                ),
              ),
              SizedBox(height: 35),
              Row(
                children: [
                  Text(
                    'Name: ',
                    style: Texts.instance.textStyle1.copyWith(height: 0),
                  ),
                  const Spacer(),
                  Text(FirebaseUser.ins.name,
                      style: Texts.instance.textStyle2.copyWith(height: 0))
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Email: ',
                    style: Texts.instance.textStyle1.copyWith(height: 0),
                  ),
                  const Spacer(),
                  Text(FirebaseUser.ins.email,
                      style: Texts.instance.textStyle2.copyWith(height: 0))
                ],
              ),
              Divider(),
              Row(
                children: [
                  Text(
                    'Password: ',
                    style: Texts.instance.textStyle1.copyWith(height: 0),
                  ),
                  const Spacer(),
                  Text(
                      settings.obscuredText
                          ? FirebaseUser.ins.password
                              .replaceAll(RegExp(r'.'), '*')
                          : FirebaseUser.ins.password,
                      style: Texts.instance.textStyle2.copyWith(height: 0)),
                  IconButton(
                      onPressed: () {
                        settings.obscureText();
                      },
                      icon: const Icon(
                        Icons.remove_red_eye,
                        opticalSize: 20,
                      )),
                ],
              ),
            ],
          );
        }),
      ),
    );
  }
}

class InfoTile extends StatelessWidget {
  const InfoTile({super.key});

  @override
  Widget build(BuildContext context) {
    return Container(
      foregroundDecoration: MagnifierDecoration(),
    );
  }
}
