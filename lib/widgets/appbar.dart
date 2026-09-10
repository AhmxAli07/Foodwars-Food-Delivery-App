// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

AppBar zAppBar(BuildContext context, String pageTitle,
    {required bool automaticallyImplyLeading}) {
  return AppBar(
    automaticallyImplyLeading: false,
    elevation: 0,
    toolbarHeight: 310,
    flexibleSpace: Stack(
      children: <Widget>[
        Image.asset(
          'assets/okay.png',
          fit: BoxFit.cover,
          width: double.infinity,
          height: 300,
        ),
        Positioned(
          child: Center(
              child: Column(
            children: [
              const SizedBox(
                height: 30,
              ),
              Image.asset(
                'assets/Logo.png',
              ),
              Text('FoodWars', style: Theme.of(context).textTheme.displayLarge),
              const Text("Bringing Your Desires Home."),
              const SizedBox(
                height: 70,
              ),
              Center(
                child: Text(pageTitle,
                    style: Theme.of(context).textTheme.titleMedium),
              ),
            ],
          )),
        ),
      ],
    ),
  );
}
