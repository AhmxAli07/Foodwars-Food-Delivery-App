// ignore_for_file: non_constant_identifier_names, unused_import, file_names, prefer_const_constructors, deprecated_member_use, use_super_parameters

import 'package:foodwars/widgets/NewRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';
import '../widgets/cont.dart';
import '../widgets/customText.dart';
import '../widgets/row.dart';

class HealthResto extends StatefulWidget {
  const HealthResto.HealthyResto({Key? key}) : super(key: key);

  @override
  State<HealthResto> createState() => _HealthRestoState();
}

class _HealthRestoState extends State<HealthResto> {
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color contColor = themeProvider.isDarkTheme
          ? Colors.black
          : Color.fromARGB(255, 249, 249, 249);
      Color barColor = themeProvider.isDarkTheme
          ? Color(0xFF252525)
          : Color.fromARGB(237, 244, 236, 227);
      return Scaffold(
          body: Stack(
        children: [
          Positioned.fill(
            child: Image.asset(
              "assets/cafe.avif",
              fit: BoxFit.cover,
            ),
          ),
          Positioned.fill(
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Container(
                    height: 300,
                  ),
                ),
                SliverList(
                  delegate: SliverChildListDelegate(
                    [
                      Container(
                        width: double.infinity,
                        height: 800,
                        decoration: BoxDecoration(
                          color: contColor,
                          borderRadius: BorderRadius.only(
                            topLeft: Radius.circular(40),
                            topRight: Radius.circular(40),
                          ),
                        ),
                        child: Column(
                          children: [
                            Center(
                                child: Container(
                              margin: EdgeInsets.only(top: 10, bottom: 15),
                              width: 85,
                              height: 5.5,
                              decoration: BoxDecoration(
                                  color: barColor,
                                  borderRadius: BorderRadius.circular(10)),
                            )),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.start,
                              children: [
                                Padding(
                                  padding: const EdgeInsets.symmetric(
                                      horizontal: 10),
                                  child: Text(
                                    'Health Conscious',
                                    style: Theme.of(context)
                                        .textTheme
                                        .titleMedium!
                                        .copyWith(
                                            fontSize: 27,
                                            fontWeight: FontWeight.w500,
                                            fontStyle: FontStyle.italic),
                                  ),
                                ),
                              ],
                            ),
                            AdjustableText(
                              text:
                                  'Health food refers to any type of food that is considered beneficial for one health and well-being. These foods are often rich in essential nutrients, vitamins, minerals. The concept of health food has gained significant importance in recent years as people become more conscious of their dietary choices and the impact of nutrition on their bodies.',
                            ),
                            SizedBox(
                              height: 10,
                            ),
                            CustomTitleRow(RowText: 'Popular Deals'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CustomContainer(
                                    imagepath: 'assets/dount.png',
                                    title: 'Sweet Dount',
                                    price: '16',
                                    Nav: '/dount',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/slice.webp',
                                    title: 'Baked Bread',
                                    price: '4',
                                    Nav: '/bread',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/sh.png',
                                    title: 'Grill Fish',
                                    price: '33',
                                    Nav: '/fish',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/Group.png',
                                    title: 'Beef',
                                    price: '45',
                                    Nav: '/beef',
                                  ),
                                ],
                              ),
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
        ],
      ));
    });
  }
}
