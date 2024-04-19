import 'package:flutter/material.dart';
import 'package:travelling/models/nav_bar_model.dart';

class BottomNavBar extends StatelessWidget {
  const BottomNavBar({super.key, required this.navBarModel});
  final NavigationBarModel navBarModel;

  static const List<IconData> _icons = [
    Icons.home_outlined,
    Icons.confirmation_num_outlined,
    Icons.favorite_border_outlined,
    Icons.person_2_outlined,
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
            BoxShadow(blurRadius: 50, color: Colors.black26),
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
                navBarModel.changeTab(index);
              },
              icon: Icon(
                  color: navBarModel.selectedItem == index
                      ? Colors.blue
                      : Colors.grey,
                  _icons[index]),
            ),
          ),
        ),
      ),
    );
  }
}
