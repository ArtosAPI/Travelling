import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:travelling/utils/texts.dart';

class ProfileTab extends StatelessWidget {
  ProfileTab({super.key});
  bool obscuredText = true;

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
      body: ListView(
        padding: EdgeInsets.all(25),
        children: [
          CircleAvatar(
            maxRadius: width / 3,
          ),
          SizedBox(height: 35),
          Row(
            children: [
              Text(
                'Name: ',
                style: Texts.instance.textStyle1.copyWith(height: 0),
              ),
              const Spacer(),
              Text('Name', style: Texts.instance.textStyle2.copyWith(height: 0))
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
              Text('Email',
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
              Text(obscuredText ? '********' : 'Password',
                  style: Texts.instance.textStyle2.copyWith(height: 0)),
              IconButton(
                  onPressed: () {},
                  icon: const Icon(
                    Icons.remove_red_eye,
                    opticalSize: 20,
                  )),
            ],
          ),
        ],
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
