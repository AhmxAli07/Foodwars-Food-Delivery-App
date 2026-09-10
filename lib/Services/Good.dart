// ignore_for_file: non_constant_identifier_names, unused_import, file_names, prefer_const_constructors, deprecated_member_use, use_super_parameters

import 'package:foodwars/widgets/NewRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';
import '../widgets/cont.dart';
import '../widgets/customText.dart';
import '../widgets/row.dart';

class GoodResto extends StatefulWidget {
  const GoodResto({Key? key}) : super(key: key);

  @override
  State<GoodResto> createState() => _GoodRestoState();
}

class _GoodRestoState extends State<GoodResto> {
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
              "assets/good.png",
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
                                    'Good Resto and Bar',
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
                                  'Most of our Alaskan Red King Crabs are expertly broken down into three distinct options: legs, claws, and lump meat. We understand that each part of the crab has its own unique appeal and culinary applications. In our online shop, we proudly offer all of these options, allowing you to choose the perfect fit for your preferences and recipes.',
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
                                    imagepath: 'assets/fries.png',
                                    title: 'Boiled Fries',
                                    price: '12',
                                    Nav: '/fri',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/coff.png',
                                    title: 'Herbal Tea',
                                    price: '8',
                                    Nav: '/t',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/sand.jpg',
                                    title: 'Ice Sandwitch',
                                    price: '10',
                                    Nav: '/sand',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/cake.jpeg',
                                    title: 'CoCo Cake',
                                    price: '9',
                                    Nav: '/cake',
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
