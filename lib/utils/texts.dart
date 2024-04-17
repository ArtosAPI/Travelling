import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

class Texts {
  static Texts instance = Texts._();

  Texts._() {
    {
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
    }
  }

  late TextStyle header;
  late TextStyle textStyle1;
  late TextStyle textStyle2;

  static const Map<String, String> texts = {
    'planYour': '''Plan your 
''',
    'luxuriousVacation': '''Luxurious 
Vacation''',
    'explore': 'Explore',
    'popular': 'Popular',
    'seeAll': 'See all',
    'find': 'Find things to do',
  };

  static const List<String> locations = [
    'Aspen, USA',
    'GTFO, USA',
    'Moscow, Russia'
  ];
  // static final String axplore = locations[0].split(', ')[0];

  static const List<String> enjoyCategories = [
    'Location',
    'Hotels',
    'Food',
    'Adventure'
  ];
}
