import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

//TODO: implement Bloc
class MainScreen extends StatelessWidget {
  MainScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: BottomNavBar(),
      body: MainScreenBody(),
    );
  }
}

class MainScreenBody extends StatefulWidget {
  MainScreenBody({super.key});
  List<bool> selections = List.generate(5, (index) => false);
  int selectedItem = 0;

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
            height: 50,
          ),
          const ChooseLocation(),
          const Text('data'),
          const SizedBox(height: 35),
          const SearchField(),
          const SizedBox(height: 35),
          SizedBox(
              height: 45,
              child: ListView(
                scrollDirection: Axis.horizontal,
                //TODO: here bloc
                children: List.generate(4, (index) {
                  return SizedBox(
                      width: widget.selectedItem == index ? null : 125,
                      child: FilledButton(
                          onPressed: () {
                            setState(() {
                              widget.selectedItem = index;
                            });
                          },
                          style: ButtonStyle(
                            backgroundColor: MaterialStatePropertyAll(
                                widget.selectedItem == index
                                    ? const Color.fromRGBO(228, 239, 255, 1)
                                    : Colors.transparent),
                          ),
                          child: Text('Adventure',
                              style: TextStyle(
                                  color: widget.selectedItem == index
                                      ? const Color.fromARGB(255, 0, 140, 255)
                                      : Colors.grey,
                                  fontWeight: FontWeight.bold))));
                }),
              )),
          const SizedBox(height: 35),
          const Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Text('data'),
              Text('data'),
            ],
          ),
          const SizedBox(height: 15),
          SizedBox(
            height: 240,
            child: ListView(
              children: const [
                Stack(
                  children: [
                    SizedBox(
                        width: 190,
                        child: Image(
                            filterQuality: FilterQuality.none,
                            image: AssetImage('assets/images/alley_palace.png')))
                  ],
                )
              ],
            ),
          )
        ]));
  }
}

//TODO: here bloc
class ChooseLocation extends StatelessWidget {
  const ChooseLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        const Text('data'),
        SizedBox(
          width: 150,
          height: 40,
          child: DropdownButton(
              elevation: 0,
              underline: const Row(
                children: [
                  Icon(Icons.location_on, color: Colors.blue),
                  Text('data'),
                ],
              ),
              isExpanded: true,
              items: const [DropdownMenuItem(value: 0, child: Text('data'))],
              onChanged: (e) {}),
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
    return const TextField(
      decoration: InputDecoration(
        filled: true,
        fillColor: Color.fromARGB(255, 238, 238, 238),
        contentPadding: EdgeInsets.only(left: 25, top: 42),
        isDense: true,
        border: OutlineInputBorder(
            borderSide: BorderSide.none,
            borderRadius: BorderRadius.horizontal(
                left: Radius.circular(50), right: Radius.circular(50))),
        hintText: 'Find things to do',
        prefixIcon: Padding(
          padding: EdgeInsets.only(left: 22, right: 15),
          child: Icon(Icons.wifi_find),
        ),
      ),
    );
  }
}

//TODO: here bloc
class BottomNavBar extends StatefulWidget {
  BottomNavBar({super.key});
  int selectedItem = 0;

  @override
  State<BottomNavBar> createState() => _BottomNavBarState();
}

class _BottomNavBarState extends State<BottomNavBar> {
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
          children: [
            IconButton(
              onPressed: () {
                setState(() {
                  widget.selectedItem = 0;
                });
              },
              icon: Icon(
                  color: widget.selectedItem == 0 ? Colors.blue : Colors.grey,
                  Icons.travel_explore),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.selectedItem = 1;
                });
              },
              icon: Icon(
                color: widget.selectedItem == 1 ? Colors.blue : Colors.grey,
                Icons.confirmation_num,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.selectedItem = 2;
                });
              },
              icon: Icon(
                color: widget.selectedItem == 2 ? Colors.blue : Colors.grey,
                Icons.favorite,
              ),
            ),
            IconButton(
              onPressed: () {
                setState(() {
                  widget.selectedItem = 3;
                });
              },
              icon: Icon(
                color: widget.selectedItem == 3 ? Colors.blue : Colors.grey,
                Icons.person,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
