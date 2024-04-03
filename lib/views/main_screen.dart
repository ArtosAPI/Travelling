import 'package:flutter/material.dart';

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

class MainScreenBody extends StatelessWidget {
  const MainScreenBody({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 34.0),
      child: ListView(
        children: const [
          const SizedBox(
            height: 50,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Text('data'),
              DropdownMenu(
                  inputDecorationTheme: InputDecorationTheme(
                      border: InputBorder.none,
                      constraints: BoxConstraints(maxWidth: 145),
                      iconColor: Colors.blue,),
                  enableFilter: true,
                  leadingIcon: Icon(Icons.location_on, color: Colors.blue),
                  dropdownMenuEntries: [
                    DropdownMenuEntry(
                        labelWidget: Text('data'), label: 'data', value: 0)
                  ]),
              // Row(children: [
              //   Icon(Icons.location_on, color: Colors.blue),
              //   Text('data'),
              // ],)
            ],
          )
        ],
      ),
    );
  }
}

//TODO: implement Bloc
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
