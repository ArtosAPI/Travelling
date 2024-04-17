import 'package:flutter/material.dart';
import 'package:travelling/Texts/texts.dart';

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
    return Padding(
        padding: const EdgeInsets.symmetric(horizontal: 34.0),
        child: ListView(children: [
          const SizedBox(
            height: 25,
          ),
          ChooseLocation(),
          const SizedBox(height: 35),
          const SearchField(),
          const SizedBox(height: 35),
          const EnjoyThings(),
          const SizedBox(height: 35),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text(Texts.texts['popular']!),
              Text(Texts.texts['seeAll']!),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 240,
            child: ListView(
                physics: const ClampingScrollPhysics(),
                scrollDirection: Axis.horizontal,
                children: const [
                  LocationCard(imagePath: 'assets/images/BrownHouse.png'),
                  SizedBox(
                    width: 30,
                  ),
                  LocationCard(imagePath: 'assets/images/CastleLake.png'),
                  SizedBox(
                    width: 30,
                  ),
                  LocationCard(imagePath: 'assets/images/WhiteRedBoat.png'),
                ]),
          ),
          const SizedBox(height: 25),
        ]));
  }
}

class LocationCard extends StatelessWidget {
  const LocationCard({
    super.key,
    required this.imagePath,
  });
  final String imagePath;

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
                  child: const Text(
                    'Alley Palace',
                    style: TextStyle(color: Colors.white),
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
                      child: const Row(
                        children: [
                          Icon(
                            Icons.star,
                            color: Color.fromARGB(255, 240, 220, 47),
                          ),
                          Text(
                            ' 4.5 ',
                            style: TextStyle(color: Colors.white),
                          ),
                        ],
                      )),
                  IconButton(
                    style: const ButtonStyle(
                        fixedSize:
                            MaterialStatePropertyAll(Size.fromRadius(20)),
                        backgroundColor: MaterialStatePropertyAll(Colors.white),
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
                        '  $currentLocation}  ',
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
