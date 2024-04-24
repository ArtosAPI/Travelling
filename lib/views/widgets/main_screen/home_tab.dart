import 'package:flutter/material.dart';
import 'package:travelling/utils/texts.dart';
import 'package:travelling/views/widgets/tabs/home_tab_widgets/home_tab_barrel.dart';

class HomeTab extends StatelessWidget {
  const HomeTab({super.key});

  @override
  Widget build(BuildContext context) {
    return ListView(children: [
      Padding(
        padding: const EdgeInsets.symmetric(horizontal: 20.0),
        child: Column(
          children: [
            const SizedBox(
              height: 25,
            ),
            const ChooseLocation(),
            const SizedBox(height: 35),
            const SearchField(),
            const SizedBox(height: 35),
            const EnjoyThings(),
            const SizedBox(height: 35),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Text(
                  Texts.texts['popular']!,
                  style: Texts.instance.textStyle1.copyWith(
                    fontSize: 18,
                    fontWeight: FontWeight.w900,
                  ),
                ),
                ShaderMask(
                  blendMode: BlendMode.srcIn,
                  shaderCallback: (bounds) => const LinearGradient(
                      begin: Alignment.topLeft,
                      end: Alignment.bottomRight,
                      colors: [
                        Color.fromRGBO(23, 111, 242, 1),
                        Color.fromRGBO(25, 110, 238, 1),
                      ]).createShader(Rect.fromLTWH(
                      bounds.left, bounds.top, bounds.height, bounds.height)),
                  child: Text(Texts.texts['seeAll']!,
                      style: Texts.instance.textStyle2.copyWith(
                        fontSize: 12,
                      )),
                ),
              ],
            ),
          ],
        ),
      ),
      const SizedBox(height: 15),
      const LocationCarousel(),
      const SizedBox(height: 25),
    ]);
  }
}
