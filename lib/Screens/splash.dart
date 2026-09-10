// ignore_for_file: camel_case_types, deprecated_member_use, prefer_const_constructors

import 'package:foodwars/Theme/theme.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

class splash extends StatefulWidget {
  const splash({super.key});

  @override
  State<splash> createState() => _splashState();
}

class _splashState extends State<splash> {
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  void initState() {
    Future.delayed(const Duration(seconds: 2), () {
      if (auth.currentUser == null) {
        // here login Screen******
        Navigator.pushReplacementNamed(context, '/login');
      } else {
        // here home Screen******
        Navigator.pushReplacementNamed(context, '/nav');
      }
    });

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color choseColor = themeProvider.isDarkTheme
          ? Colors.black // Set your dark theme color
          : Colors.white; // Set your light theme color
      return Scaffold(
        backgroundColor: choseColor,
        appBar: AppBar(
          elevation: 0,
          toolbarHeight: 330,
          flexibleSpace: SafeArea(
            child: Image.asset(
              'assets/okay.png',
              fit: BoxFit.cover,
            ),
          ),
        ),
        body: SingleChildScrollView(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Center(child: Image.asset('assets/Logo.png')),
              Center(
                  child: Text(
                'FoodWars',
                style: Theme.of(context).textTheme.displayLarge!.copyWith(),
              )),
              const Text("Bringing Your Desires Home."),
            ],
          ),
        ),
      );
    });
  }
}
