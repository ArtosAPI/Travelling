import 'package:flutter/material.dart';
import '../../../../utils/texts.dart';

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
