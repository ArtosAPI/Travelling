import 'package:flutter/material.dart';
import 'package:travelling/Texts/texts.dart';

class FirstScreen extends StatelessWidget {
  const FirstScreen({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    return Scaffold(
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
          children: [
            Text(
              'Aspen',
              style: Texts.instance.header,
            ),
            SizedBox(
              height: height / 3.2,
            ),
            Container(
                padding: EdgeInsets.only(left: 35),
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
            const SizedBox(height: 35),
            FilledButton(
              onPressed: () {},
              style: const ButtonStyle(
                  minimumSize: MaterialStatePropertyAll(Size(311, 50)),
                  backgroundColor: MaterialStatePropertyAll(Colors.blue)),
              child: Text(Texts.texts['explore']!),
            )
          ],
        ),
      ),
    );
  }
}
