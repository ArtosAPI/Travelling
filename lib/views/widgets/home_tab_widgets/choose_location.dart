import 'package:flutter/material.dart';
import '../../../utils/texts.dart';

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
