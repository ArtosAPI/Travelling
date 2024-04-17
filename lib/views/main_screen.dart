import 'dart:io';
import 'dart:ui';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:travelling/utils/texts.dart';
import 'package:travelling/views/first_screen.dart';

//TODO: implement Bloc
class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: const MainScreenBody(),
    );
  }
}

class MainScreenBody extends StatefulWidget {
  const MainScreenBody({super.key});

  @override
  State<MainScreenBody> createState() => _MainScreenBodyState();
}

class _MainScreenBodyState extends State<MainScreenBody> {
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

class LocationCarousel extends StatelessWidget {
  const LocationCarousel({
    super.key,
  });

  static const List<String> images = [
    'assets/images/BrownHouse.png',
    'assets/images/CastleLake.png',
    'assets/images/WhiteRedBoat.png'
  ];

  static const List<String> names = [
    'Brown House',
    'Castle Lake',
    'White Red Boat'
  ];

  static const List<double> stars = [4.5, 4.7, 4.9];

  static const List<String> descriptions = [
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.',
    'Lorem ipsum dolor sit amet, consectetur adipiscing elit, sed do eiusmod tempor incididunt ut labore et dolore magna aliqua. Ut enim ad minim veniam, quis nostrud exercitation ullamco laboris nisi ut aliquip ex ea commodo consequat. Duis aute irure dolor in reprehenderit in voluptate velit esse cillum dolore eu fugiat nulla pariatur. Excepteur sint occaecat cupidatat non proident, sunt in culpa qui officia deserunt mollit anim id est laborum.'
  ];

  // static const List<Widget> LocationDescriptions = [
  //   LocationDescription(),
  //   LocationDescription(),
  //   LocationDescription(),
  // ];

  @override
  Widget build(BuildContext context) {
    return Container(
      padding: const EdgeInsets.only(
        left: 20.0,
      ),
      height: 240,
      child: ListView(
          physics: const ClampingScrollPhysics(),
          scrollDirection: Axis.horizontal,
          children: List.generate(
            images.length,
            (index) => Padding(
              padding: const EdgeInsets.only(right: 20),
              child: LocationCard(
                imagePath: images[index],
                name: names[index],
                star: stars[index],
                description: descriptions[index],
              ),
            ),
          )),
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
  });
  final String imagePath;
  final String name;
  final double star;
  final String description;

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
                      onPressed: () {},
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

class LocationDescription extends StatelessWidget {
  const LocationDescription({
    super.key,
    required this.imagePath,
    required this.name,
    required this.star,
    required this.description,
  });
  final String imagePath;
  final String name;
  final double star;
  final String description;

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        decoration: const BoxDecoration(color: Colors.white),
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: ListView(
            children: [
              SizedBox(
                height: 375,
                width: double.infinity,
                child: Stack(
                  children: [
                    ClipRRect(
                      borderRadius: BorderRadius.circular(20),
                      child: SizedBox(
                        height: 340,
                        width: double.infinity,
                        child: Image(
                          image: AssetImage(imagePath),
                          fit: BoxFit.cover,
                        ),
                      ),
                    ),
                    Positioned(
                      top: 10,
                      left: 10,
                      child: IconButton(
                        icon: const Icon(Icons.arrow_back),
                        onPressed: () {
                          Navigator.pop(context);
                        },
                        style: const ButtonStyle(
                          maximumSize: MaterialStatePropertyAll(Size(40, 40)),
                          shape: MaterialStatePropertyAll(
                              RoundedRectangleBorder(
                                  borderRadius:
                                      BorderRadius.all(Radius.circular(8)))),
                          backgroundColor:
                              MaterialStatePropertyAll(Colors.white),
                        ),
                      ),
                    ),
                    Positioned(
                        top: 315,
                        left: MediaQuery.of(context).size.width / 1.45,
                        child: Container(
                          decoration: const BoxDecoration(
                              shape: BoxShape.circle,
                              boxShadow: [
                                BoxShadow(
                                  color: Color.fromARGB(255, 146, 186, 255),
                                  blurRadius: 15,
                                )
                              ]),
                          child: IconButton(
                            style: const ButtonStyle(
                                iconSize: MaterialStatePropertyAll(35),
                                fixedSize: MaterialStatePropertyAll(
                                    Size.fromRadius(25)),
                                backgroundColor:
                                    MaterialStatePropertyAll(Colors.white),
                                shape:
                                    MaterialStatePropertyAll(CircleBorder())),
                            icon: const Icon(
                              Icons.favorite,
                              color: Colors.red,
                            ),
                            onPressed: () {},
                          ),
                        )),
                  ],
                ),
              ),
              const SizedBox(
                height: 8,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    name,
                    style: Texts.instance.textStyle1.copyWith(
                        fontSize: 24, fontWeight: FontWeight.bold, height: 0),
                  ),
                  ShaderMask(
                      blendMode: BlendMode.srcIn,
                      shaderCallback: (bounds) => const LinearGradient(
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight,
                              colors: [
                                Color.fromRGBO(23, 111, 242, 1),
                                Color.fromRGBO(25, 110, 238, 1),
                              ]).createShader(
                            Rect.fromLTWH(0, 0, bounds.width, bounds.height),
                          ),
                      child: Text(
                        'Show map',
                        style: Texts.instance.textStyle2
                            .copyWith(fontWeight: FontWeight.bold, height: 0),
                      ))
                ],
              ),
              Padding(
                padding: const EdgeInsets.only(top: 16, bottom: 32),
                child: Row(
                  children: [
                    ShaderMask(
                        blendMode: BlendMode.srcIn,
                        shaderCallback: (bounds) => const LinearGradient(
                                begin: Alignment.centerLeft,
                                end: Alignment.centerRight,
                                colors: [
                                  Color.fromRGBO(180, 120, 32, 1),
                                  Color.fromRGBO(223, 150, 82, 1),
                                ]).createShader(Rect.fromLTWH(
                                0, 0, bounds.width, bounds.height)),
                        child: const Icon(Icons.star)),
                    Text(
                      '   $star',
                      style: Texts.instance.textStyle2
                          .copyWith(height: 0, color: Colors.black54),
                    )
                  ],
                ),
              ),
              Text(description, style: Texts.instance.textStyle2),
              Padding(
                padding: const EdgeInsets.only(top: 30, bottom: 12),
                child: Text('Facilities',
                    style: Texts.instance.textStyle1
                        .copyWith(fontWeight: FontWeight.bold)),
              ),
              SizedBox(
                height: 77,
                child: ListView(scrollDirection: Axis.horizontal, children: const [
                  Facility(icon: Icons.connected_tv, text: '1 Heater'),
                  SizedBox(width: 14,),
                  Facility(icon: Icons.dinner_dining, text: 'Dinner'),
                  SizedBox(width: 14,),
                  Facility(icon: Icons.hot_tub, text: '1 Tub'),
                  SizedBox(width: 14,),
                  Facility(icon: Icons.pool, text: 'Pool'),
                  SizedBox(width: 14,),
                ]),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class Facility extends StatelessWidget {
  const Facility({super.key, required this.icon, required this.text});
  final IconData icon;
  final String text;
  final Color _mainColor = Colors.grey;

  @override
  Widget build(BuildContext context) {
    return Align(
      alignment: Alignment.centerLeft,
      child: ClipRRect(
        borderRadius: const BorderRadius.all(Radius.circular(16)),
        child: Container(
          width: 77,
          height: 77,
          color: Color.fromRGBO(23, 111, 242, 0.171),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Icon(
                icon,
                color: _mainColor,
                size: 32,
              ),
              Text(text,
                  style: Texts.instance.textStyle2.copyWith(color: _mainColor)),
            ],
          ),
        ),
      ),
    );
  }
}

//TODO: here bloc
class ChooseLocation extends StatefulWidget {
  const ChooseLocation({
    super.key,
  });

  @override
  State<ChooseLocation> createState() => _ChooseLocationState();
}

class _ChooseLocationState extends State<ChooseLocation> {
  String currentLocation = Texts.locations[0];

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(Texts.texts['explore']!,
                style: Texts.instance.textStyle1
                    .copyWith(fontSize: 14, fontWeight: FontWeight.w600)),
            Container(
              width: 250,
              height: 40,
              color: const Color.fromRGBO(255, 251, 254, 1),
              child: DropdownButton(
                  borderRadius: const BorderRadius.all(Radius.circular(25)),
                  iconSize: 0,
                  elevation: 0,
                  underline: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    mainAxisSize: MainAxisSize.min,
                    children: [
                      const Icon(Icons.location_on, color: Colors.blue),
                      Text(
                        '  $currentLocation  ',
                        style: Texts.instance.textStyle2.copyWith(
                          fontSize: 12,
                        ),
                      ),
                      const Icon(Icons.pin_drop, color: Colors.blue),
                    ],
                  ),
                  isExpanded: true,
                  items: List.generate(
                      Texts.locations.length,
                      (index) => DropdownMenuItem(
                          value: index,
                          child: SizedBox(
                            width: 200,
                            child: Column(
                              children: [
                                Text(Texts.locations[index]),
                                const Divider()
                              ],
                            ),
                          ))),
                  onChanged: (e) {
                    setState(() {
                      currentLocation = Texts.locations[e ?? 0];
                    });
                  }),
            ),
          ],
        ),
        Text(
          currentLocation.split(', ')[0],
          textAlign: TextAlign.start,
          style: Texts.instance.textStyle1
              .copyWith(fontSize: 32, fontWeight: FontWeight.w600, height: 0.5),
        ),
      ],
    );
  }
}

//TODO: here bloc
class SearchField extends StatelessWidget {
  const SearchField({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: const Color.fromARGB(255, 238, 238, 238),
        contentPadding: const EdgeInsets.only(left: 25, top: 42),
        isDense: true,
        border: const OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(50), right: Radius.circular(50))),
        hintText: Texts.texts['find'],
        hintStyle: Texts.instance.textStyle2,
        prefixIcon: const Padding(
          padding: EdgeInsets.only(left: 22, right: 15),
          child: Icon(Icons.wifi_find),
        ),
      ),
    );
  }
}

class EnjoyThings extends StatefulWidget {
  const EnjoyThings({super.key});

  @override
  State<EnjoyThings> createState() => _EnjoyThingsState();
}

class _EnjoyThingsState extends State<EnjoyThings> {
  List<bool> selections = List.generate(5, (index) => false);
  int selectedItem = 0;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
        height: 45,
        child: ListView(
          scrollDirection: Axis.horizontal,
          //TODO: here bloc
          children: List.generate(4, (index) {
            return SizedBox(
                width: 115,
                child: FilledButton(
                    onPressed: () {
                      setState(() {
                        selectedItem = index;
                      });
                    },
                    style: ButtonStyle(
                      backgroundColor: MaterialStatePropertyAll(
                          selectedItem == index
                              ? const Color.fromRGBO(228, 239, 255, 1)
                              : Colors.transparent),
                    ),
                    child: Text(Texts.enjoyCategories[index],
                        style: TextStyle(
                            color: selectedItem == index
                                ? const Color.fromARGB(255, 0, 140, 255)
                                : Colors.grey,
                            fontWeight: FontWeight.bold))));
          }),
        ));
  }
}

//TODO: here bloc
class BottomNavBar extends StatefulWidget {
  const BottomNavBar({super.key});

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
  int selectedItem = 0;

  List<IconData> icons = [
    Icons.travel_explore,
    Icons.confirmation_num,
    Icons.favorite,
    Icons.person,
  ];

  @override
  Widget build(BuildContext context) {
    double height = MediaQuery.of(context).size.height;
    double width = MediaQuery.of(context).size.width;

    return Container(
      height: height / 12,
      width: width,
      decoration: const BoxDecoration(
          boxShadow: [
            BoxShadow(blurRadius: 50, color: Colors.black12),
          ],
          color: Colors.white,
          borderRadius: BorderRadius.only(
            topLeft: Radius.circular(35),
            topRight: Radius.circular(35),
          )),
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 42.0),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: List.generate(
            4,
            (index) => IconButton(
              onPressed: () {
                setState(() {
                  selectedItem = index - 1;
                });
              },
              icon: Icon(
                  color: selectedItem == index - 1 ? Colors.blue : Colors.grey,
                  icons[index]),
            ),
          ),
        ),
      ),
    );
  }
}
