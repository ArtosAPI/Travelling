import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:travelling/models/location_card_model.dart';
import 'package:travelling/models/nav_bar_model.dart';
import 'package:travelling/views/widgets/main_screen/favourites_tab.dart';
import 'package:travelling/views/widgets/main_screen/main_screen_barrel.dart';
import 'package:travelling/views/widgets/main_screen/profile_tab.dart';

class MainScreen extends StatelessWidget {
  const MainScreen({super.key});

  Widget chosenTab(int selectedTab) {
    switch (selectedTab) {
      case 0:
        return const HomeTab();
      case 1:
        return Container(color: Colors.green);
      case 2:
        return const FavouritesTab();
      case 3:
        return const ProfileTab();
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
          extendBodyBehindAppBar: true,
          bottomNavigationBar: BottomNavBar(
            navBarModel: navBar,
          ),
          body: chosenTab(navBar.selectedItem),
        ),
      ),
    );
  }
}
