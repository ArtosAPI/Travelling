import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling/models/location_card_model.dart';
import 'package:travelling/models/nav_bar_model.dart';
import 'package:travelling/views/widgets/main_screen/main_screen_barrel.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget chosenTab(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const HomeTab();
      case 1:
        return Container(color: Colors.green);
      case 2:
        return Container(color: Colors.blue);
      case 3:
        return Container(color: Colors.red);
      default:
        return const HomeTab();
    }
  }

  @override
  Widget build(BuildContext context) {
    return MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (context) => NavigationBarModel()),
        ChangeNotifierProvider(create: (context) => LocationCardsModel()),
      ],
      child: Consumer(
        builder: (context, NavigationBarModel navBar, child) => Scaffold(
          extendBody: true,
          bottomNavigationBar: BottomNavBar(
            navBarModel: navBar,
          ),
          body: chosenTab(navBar.selectedItem),
        ),
      ),
    );
  }
}
