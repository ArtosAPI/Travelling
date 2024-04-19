import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling/models/location_card_model.dart';
import 'package:travelling/views/widgets/home_tab_widgets/location_description.dart';

class LocationCarousel extends StatelessWidget {
  const LocationCarousel({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      height: 240,
      child: Consumer(
          builder: (context, LocationCardsModel locationCardModel, child) {
        return ListView(
            physics: const ClampingScrollPhysics(),
            scrollDirection: Axis.horizontal,
            children: List.generate(
              locationCardModel.locations.length,
              (index) => Padding(
                padding: const EdgeInsets.only(right: 20),
                child: LocationCard(
                  imagePath: locationCardModel.locations[index].image,
                  name: locationCardModel.locations[index].name,
                  star: locationCardModel.locations[index].star,
                  description: locationCardModel.locations[index].description,
                  like: () => locationCardModel.likeLocation(index),
                ),
              ),
            ));
      }),
    );
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.imagePath,
    required this.name,
    required this.star,
    required this.description,
    required this.like,
  });
  final String imagePath;
  final String name;
  final double star;
  final String description;
  final void Function()? like;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => Navigator.push(
          context,
          MaterialPageRoute(
              builder: (context) => LocationDescription(
                    imagePath: imagePath,
                    name: name,
                    star: star,
                    description: description,
                  ))),
      child: ClipRRect(
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
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 12),
                        decoration: const BoxDecoration(
                            color: Color.fromARGB(255, 119, 119, 119),
                            borderRadius: BorderRadius.horizontal(
                                left: Radius.circular(50),
                                right: Radius.circular(50))),
                        child: Row(
                          children: [
                            const Icon(
                              Icons.star,
                              color: Color.fromARGB(255, 240, 220, 47),
                            ),
                            Text(
                              ' $star ',
                              style: const TextStyle(color: Colors.white),
                            ),
                          ],
                        )),
                    IconButton(
                      style: const ButtonStyle(
                          fixedSize:
                              MaterialStatePropertyAll(Size.fromRadius(20)),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                          shape: MaterialStatePropertyAll(CircleBorder())),
                      icon: const Icon(
                        Icons.favorite,
                        color: Colors.red,
                      ),
                      onPressed: like,
                    )
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
