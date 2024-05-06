import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling/models/location_card_model.dart';

class FavouritesTab extends StatelessWidget {
  const FavouritesTab({super.key});

  @override
  Widget build(BuildContext context) {
    final favouriteLocations = Provider.of<LocationCardsModel>(context)
        .locations
        .where((element) => element.liked)
        .toList();

    favouriteLocations.sort((a, b) => a.name.compareTo(b.name));

    return Padding(
      padding: const EdgeInsets.all(15),
      child: ListView.separated(
          itemCount: favouriteLocations.length,
          separatorBuilder: (context, index) => const Divider(
                indent: 50,
                endIndent: 50,
                thickness: 2,
                height: 25,
              ),
          itemBuilder: (_, index) => FavouriteLocationCard(
                imagePath: favouriteLocations[index].image,
                name: favouriteLocations[index].name,
              )),
    );
  }
}

class FavouriteLocationCard extends StatelessWidget {
  const FavouriteLocationCard({
    super.key,
    required this.imagePath,
    required this.name,
  });
  final String imagePath;
  final String name;

  @override
  Widget build(BuildContext context) {
    return ClipRRect(
      borderRadius: const BorderRadius.all(Radius.circular(30)),
      child: Container(
        width: 160,
        height: 240,
        decoration: BoxDecoration(
            image: DecorationImage(
                fit: BoxFit.cover, image: AssetImage(imagePath))),
        child: Padding(
          padding: const EdgeInsets.only(
            left: 15,
            bottom: 5,
            right: 8,
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.end,
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Container(
                  padding:
                      const EdgeInsets.symmetric(vertical: 4, horizontal: 15),
                  decoration: const BoxDecoration(
                      color: Color.fromARGB(255, 119, 119, 119),
                      borderRadius: BorderRadius.horizontal(
                          left: Radius.circular(75),
                          right: Radius.circular(75))),
                  child: Text(
                    name,
                    style: const TextStyle(color: Colors.white),
                  )),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    padding:
                        const EdgeInsets.symmetric(vertical: 4, horizontal: 12),
                    decoration: const BoxDecoration(
                        color: Color.fromARGB(255, 119, 119, 119),
                        borderRadius: BorderRadius.horizontal(
                            left: Radius.circular(50),
                            right: Radius.circular(50))),
                  ),
                ],
              )
            ],
          ),
        ),
      ),
    );
  }
}
