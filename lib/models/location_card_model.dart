import 'package:flutter/material.dart';
import 'package:travelling/utils/locations_cards_info.dart';

class LocationCardsModel extends ChangeNotifier {
  List<LocationCardModel> locations = locationCards;

  void likeLocation(int id) {
    locations[id].like();
    notifyListeners();
  }

  get allLikedLocations {
    locations.where((element) => element.liked).toList();
  }
}

class LocationCardModel {
  bool liked = false;
  final double star;
  final String image, name, description;

  LocationCardModel({
    required this.image,
    required this.name,
    required this.star,
    required this.description,
  });

  void like() {
    liked = !liked;
  }
}
