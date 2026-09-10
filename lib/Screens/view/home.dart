// ignore_for_file: deprecated_member_use, sized_box_for_whitespace, prefer_const_constructors, unused_import, non_constant_identifier_names, use_super_parameters

import 'package:foodwars/widgets/Toggle.dart';
import 'package:foodwars/widgets/container.dart';
import 'package:foodwars/widgets/slider.dart';
import 'package:carousel_slider/carousel_slider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/theme.dart';
import '../../widgets/SearchBar.dart';
import '../../widgets/SearchBar2.dart';
import '../../widgets/custom.dart';
import '../../widgets/row.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  State<Home> createState() => _HomeState();
}

class _HomeState extends State<Home> {
  bool isSwitched = false;
  final FirebaseAuth auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomAppBar(customText: 'Find your \nFavourite Food'),
            SizedBox(height: 18),
            Row(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(child: CustomSearchBar()),
                ThemeToggleButton(),
              ],
            ),
            SizedBox(height: 4),
            Carsolslider(),
            SizedBox(height: 6),
            CustomTitleRow(RowText: 'Nearest Restaurant'),
            SizedBox(height: 8),
            SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              child: Row(
                children: [
                  // IconButton(
                  //     onPressed: () async {
                  //       await auth.signOut();
                  //       Navigator.pushNamed(context, '/login');
                  //     },
                  //     icon: const Icon(Icons.image)),
                  CustomCont(
                      title: 'Good Food',
                      image: "assets/resto.png",
                      Nav: "/good"),
                  CustomCont(
                      title: 'Vegan Resto',
                      image: "assets/vegan.png",
                      Nav: "/vegan"),
                  CustomCont(
                      title: 'Healthy Food',
                      image: "assets/health.png",
                      Nav: "/healthy"),
                  CustomCont(
                      title: 'Smart Resto',
                      image: "assets/smart.png",
                      Nav: "/smart"),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
