import 'package:flutter/material.dart';
import 'package:travelling/firebase/firebase_cruds.dart';
import 'package:travelling/utils/locations_cards_info.dart';

class LocationCardsModel extends ChangeNotifier {
  List<LocationCardModel> locations = locationCards;

  void likeLocation(int id) {
    locations[id].like();
    notifyListeners();
  }

  List<LocationCardModel> get allLikedLocations =>
      locations.where((element) => element.liked).toList();
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
  }) {
    for (int i = 0; i < FirebaseUser.ins!.likedCards.length; i++) {
      if (FirebaseUser.ins!.likedCards[i] == name) {
        liked = true;
      }
    }
  }

  void like() {
    liked = !liked;
  }
}
