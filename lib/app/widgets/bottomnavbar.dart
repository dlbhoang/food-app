import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:flutter/material.dart';
import 'package:food_app/app/screens/home/home_screen.dart';

import '../screens/order/order_screen.dart';
import '../screens/profile/profile_screen.dart';
import '../screens/wallet/wallet_screen.dart';

// ignore: must_be_immutable
class BotomNavBar extends StatefulWidget {
  static const routeName='/botomnvabar';
  const BotomNavBar({super.key});

  @override
  State<BotomNavBar> createState() => _BotomNavBarState();
}

class _BotomNavBarState extends State<BotomNavBar> {
  int currentTabIndex = 0;

  late List<Widget> pages;
  late Widget currentPage;
  late HomeScreen homePage;
  late Profile profilePage;
  late Order orderPage;
  late Wallet walletPage;
  @override
  void initState() {
    homePage = const HomeScreen();
    profilePage = const Profile();
    orderPage = const Order();
    walletPage = const Wallet();
    pages = [homePage, orderPage, walletPage, profilePage];
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      bottomNavigationBar: CurvedNavigationBar(
          height: 65.0,
          backgroundColor: Colors.white,
          color: Colors.black,
          animationDuration: const Duration(milliseconds: 500),
          // ignore: prefer_const_literals_to_create_immutables
          onTap: (int index) {
            setState(() {
              currentTabIndex = index;
            });
          },
          // ignore: prefer_const_literals_to_create_immutables
          items:  [
            const Icon(Icons.home_outlined, color: Colors.white),
            const Icon(
              Icons.shopping_bag_outlined,
              color: Colors.white,
            ),
            const Icon(
              Icons.wallet_outlined,
              color: Colors.white,
            ),
            const Icon(
              Icons.person_outline,
              color: Colors.white,
            )
          ]),
      body: pages[currentTabIndex],
    );
  }
}
