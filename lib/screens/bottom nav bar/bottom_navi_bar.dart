import 'package:cloth_ecommerce_application/screens/bag%20page/bag_page.dart';
import 'package:cloth_ecommerce_application/screens/favourite%20page/favourite_page.dart';
import 'package:cloth_ecommerce_application/screens/shop%20page/shop_page.dart';
import 'package:flutter/material.dart';
import 'package:persistent_bottom_nav_bar_v2/persistent_bottom_nav_bar_v2.dart';

import '../home page/home_page.dart';
import '../profile page/profile_page.dart';

class BottomNaviBar extends StatefulWidget {
  const BottomNaviBar({super.key});

  @override
  State<BottomNaviBar> createState() => _BottomNaviBarState();
}

List<String> bottomNavBarTitle = [
  "Home",
  "Shop",
  "Bag",
  "Favourite",
  "Profile",
];
List<Widget> bottomNavBarPages = [
  HomePage(),
  ShopPage(),
  BagPage(),
  FavouritePage(),
  ProfilePage(),
];
List<Icon> bottomNavBaricons = [
  Icon(Icons.home),
  Icon(Icons.shopping_cart),
  Icon(Icons.shopping_bag),
  Icon(Icons.favorite),
  Icon(Icons.person),
];

class _BottomNaviBarState extends State<BottomNaviBar> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        bottomNavigationBar: PersistentTabView(
          tabs: List.generate(
            bottomNavBarPages.length,
            (index) => PersistentTabConfig(
              screen: bottomNavBarPages[index],
              item: ItemConfig(
                icon: bottomNavBaricons[index],
                title: bottomNavBarTitle[index],
                activeForegroundColor: Theme.of(context).primaryColor,
              ),
            ),
          ),
          navBarBuilder:
              (navBarConfig) => Style1BottomNavBar(navBarConfig: navBarConfig),
        ),
      ),
    );
  }
}
