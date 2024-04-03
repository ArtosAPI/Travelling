import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Texts {
  static Texts instance = Texts._();

  Texts._() {
    header = const TextStyle(
        fontFamily: 'Hiatus',
        fontSize: 116,
        color: Colors.white,
        letterSpacing: 8.5);
    textStyle1 = GoogleFonts.montserrat().copyWith(fontSize: 24);
    textStyle2 = const TextStyle(
      fontFamily: 'Circular',
      fontSize: 14,
    );

    textw1 = RichText(
      textAlign: TextAlign.start,
        text: TextSpan(text: text1, style: textStyle1, children: [
      TextSpan(
        text: text2,
        style: textStyle1.copyWith(fontSize: 40, fontWeight: FontWeight.bold),
      )
    ]));
  }

  late TextStyle header;
  late TextStyle textStyle1;
  late TextStyle textStyle2;

  late RichText textw1;
  static const text1 = '''Plan your 
''';
static const text2 = '''Luxurious 
Vacation''';
  static const text3 = 'Explore';
}
