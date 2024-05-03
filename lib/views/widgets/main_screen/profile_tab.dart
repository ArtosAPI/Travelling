import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling/firebase/firebase_cruds.dart';
import 'package:travelling/models/profile_settings.dart';
import 'package:travelling/utils/texts.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});

  @override
  Widget build(BuildContext context) {
    final width = MediaQuery.of(context).size.width;

    return Scaffold(
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
        body: MultiProvider(
            providers: [
              ChangeNotifierProvider(create: (context) => AvatarImage()),
              ChangeNotifierProvider(create: (context) => ProfilePassword())
            ],
            child: ListView(
              padding: EdgeInsets.all(25),
              children: [
                SizedBox(height: 35),
                Consumer(builder: (context, AvatarImage settings, child) {
                  return GestureDetector(
                      onDoubleTap: () {
                        settings.setAvatarImage();
                      },
                      child: CircleAvatar(
                        backgroundImage: AvatarImage.image != null
                            ? MemoryImage(AvatarImage.image!)
                            : null,
                        maxRadius: width / 3,
                      ));
                }),
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
                Consumer(builder: (_, ProfilePassword profilePassword, child) {
                  return Row(
                    children: [
                      Text(
                        'Password: ',
                        style: Texts.instance.textStyle1.copyWith(height: 0),
                      ),
                      const Spacer(),
                      Text(
                          profilePassword.obscurePassword
                              ? FirebaseUser.ins.password
                                  .replaceAll(RegExp(r'.'), '*')
                              : FirebaseUser.ins.password,
                          style: Texts.instance.textStyle2.copyWith(height: 0)),
                      IconButton(
                          onPressed: () {
                            profilePassword.obscureText();
                          },
                          icon: const Icon(
                            Icons.remove_red_eye,
                            opticalSize: 20,
                          )),
                    ],
                  );
                }),
              ],
            )));
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
