// ignore_for_file: prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors, prefer_const_constructors_in_immutables

import 'package:badges/badges.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:badges/badges.dart' as badges;
import '../Theme/theme.dart';

class CustomAppBar extends StatelessWidget {
  final String customText;
  CustomAppBar({required this.customText});
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color contColor = themeProvider.isDarkTheme
          ? const Color.fromARGB(149, 0, 0, 0)
          : Colors.white;
      return SafeArea(
        child: Stack(
          children: [
            Image.asset(
              'assets/top.png',
              fit: BoxFit.cover,
              height: 145,
              width: double.infinity,
            ),
            Positioned(
              top: 35,
              right: 45,
              child: InkWell(
                onTap: () {
                  Navigator.pushNamed(context, '/not');
                },
                child: Container(
                  decoration: BoxDecoration(
                    color: contColor,
                    borderRadius: BorderRadius.circular(10),
                  ),
                  width: 55,
                  height: 55,
                  child: badges.Badge(
                    position: BadgePosition.topEnd(top: 11, end: 9),
                    badgeContent: Container(
                      width: 2,
                      height: 2,
                      decoration: BoxDecoration(
                        color: Colors.red,
                        shape: BoxShape.circle,
                      ),
                    ),
                    child: Center(
                      child: Icon(
                        Icons.notifications,
                        size: 35,
                        color: Color(0xFF4EE489),
                      ),
                    ),
                  ),
                ),
              ),
            ),
            Positioned(
              left: 10,
              bottom: 1,
              child: Text(
                customText,
                textAlign: TextAlign.start,
                style: Theme.of(context).textTheme.titleSmall,
              ),
            ),
          ],
        ),
      );
    });
  }
}
