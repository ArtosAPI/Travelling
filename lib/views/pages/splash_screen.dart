import 'package:flutter/material.dart';
import 'package:go_router/go_router.dart';
import 'package:travelling/utils/texts.dart';

class SplashScreen extends StatelessWidget {
  const SplashScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return FutureBuilder(
      future: Future.delayed(const Duration(seconds: 1, milliseconds: 5),
          () => context.go('/MainScreen')),
      builder: (context, snapshot) => Scaffold(
        body: Container(
          height: double.infinity,
          width: double.infinity,
          padding: const EdgeInsets.only(top: 100),
          decoration: const BoxDecoration(
              image: DecorationImage(
                  fit: BoxFit.fill,
                  image: AssetImage(
                    'assets/images/background.png',
                  ))),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(
                'Aspen',
                style: Texts.instance.header,
              ),
              Padding(
                padding: const EdgeInsets.only(bottom: 35, left: 35),
                child: Align(
                    alignment: Alignment.centerLeft,
                    child: RichText(
                        textAlign: TextAlign.start,
                        text: TextSpan(
                            text: Texts.texts['planYour'],
                            style: Texts.instance.textStyle1,
                            children: [
                              TextSpan(
                                text: Texts.texts['luxuriousVacation'],
                                style: Texts.instance.textStyle1.copyWith(
                                    fontSize: 40, fontWeight: FontWeight.bold),
                              )
                            ]))),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
