import 'package:flutter/material.dart';
import 'package:travelling/utils/texts.dart';

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
