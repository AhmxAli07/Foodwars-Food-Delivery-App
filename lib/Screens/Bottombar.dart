// ignore_for_file: file_names, prefer_final_fields, prefer_const_constructors, prefer_const_literals_to_create_immutables, use_key_in_widget_constructors, library_private_types_in_public_api, unused_import, deprecated_member_use

import 'package:foodwars/Screens/view/cart.dart';
import 'package:foodwars/Screens/view/home.dart';
import 'package:foodwars/Screens/view/profile.dart';
import 'package:foodwars/Theme/theme.dart';
import 'package:foodwars/widgets/Toggle.dart';
import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:google_nav_bar/google_nav_bar.dart';
import 'package:provider/provider.dart';
import '../widgets/CartRoundB.dart';
import '../widgets/badge.dart';
import 'view/CHAT.dart';

class Navbar extends StatefulWidget {
  @override
  _NavbarState createState() => _NavbarState();

  void updateBadgeCount(int cartBadgeCount) {}
}

class _NavbarState extends State<Navbar> {
  int cartBadgeCount = 1;
  int _selectedIndex = 0;
  int badgeCount = 0;
  void updateBadgeCount(int count) {
    setState(() {
      cartBadgeCount = count;
    });
  }

  static List<Widget> _widgetOptions = <Widget>[
    Home(),
    Profile(),
    cart(),
    chat()
  ];

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color containerColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Colors.white; // Set your light theme color
      return Scaffold(
        body: Center(
          child: _widgetOptions.elementAt(_selectedIndex),
        ),
        bottomNavigationBar: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topLeft: Radius.circular(25), topRight: Radius.circular(25)),
            color: containerColor,
            boxShadow: [],
          ),
          child: SafeArea(
            child: Padding(
              padding: EdgeInsets.all(10),
              child: GNav(
                textStyle: TextStyle(
                  fontSize: 21,
                  color: Colors.black,
                ),
                tabBorderRadius: 15,
                rippleColor: Colors.grey[300]!,
                hoverColor: Colors.grey[100]!,
                gap: 8,
                activeColor: Colors.black,
                iconSize: 34,
                padding: EdgeInsets.symmetric(horizontal: 15, vertical: 8),
                duration: Duration(milliseconds: 400),
                tabBackgroundColor: Color(0xFFEBFBF3),
                color: Color(0xFF31D080),
                tabs: [
                  GButton(
                    iconActiveColor: Color(0xFF31D080),
                    icon: Icons.home,
                    text: 'Home',
                  ),
                  GButton(
                    iconActiveColor: Color(0xFF31D080),
                    icon: Icons.person,
                    text: 'Profile',
                  ),
                  GButton(
                    icon: Icons.shopping_cart,
                    leading: CartBadge(
                      badgeCount: cartBadgeCount,
                    ),
                    iconActiveColor: Color(0xFF31D080),
                    text: 'Cart',
                  ),
                  GButton(
                    iconActiveColor: Color(0xFF31D080),
                    icon: Icons.message,
                    text: 'Messages',
                  ),
                ],
                selectedIndex: _selectedIndex,
                onTabChange: (index) {
                  setState(() {
                    _selectedIndex = index;
                  });
                },
              ),
            ),
          ),
        ),
      );
    });
  }
}
