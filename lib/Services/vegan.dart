// ignore_for_file: non_constant_identifier_names, unused_import, file_names, prefer_const_constructors, deprecated_member_use, use_super_parameters

import 'package:foodwars/widgets/NewRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';
import '../widgets/cont.dart';
import '../widgets/customText.dart';
import '../widgets/row.dart';

class VeganResto extends StatefulWidget {
  const VeganResto({Key? key}) : super(key: key);

  @override
  State<VeganResto> createState() => _VeganRestoState();
}

class _VeganRestoState extends State<VeganResto> {
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
              "assets/vegan.avif",
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
                                    'Vegan Restaurant',
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
                                  'Indulge in the world of plant-based goodness with our Vegan Delights collection. Discover three tempting options,  savory meat alternatives, and flavorful plant-based sauces. Our online shop is offering a carefully curated selection crafted with precision and expertise.Elevate your plant-based cuisine with our thoughtfully chosen offerings and relish the delightful possibilities of vegan gastronomy.',
                            ),
                            SizedBox(
                              height: 5,
                            ),
                            CustomTitleRow(RowText: 'Popular Deals'),
                            SingleChildScrollView(
                              scrollDirection: Axis.horizontal,
                              child: Row(
                                children: [
                                  CustomContainer(
                                    imagepath: 'assets/salad.png',
                                    title: 'Avocado Salad',
                                    price: '18',
                                    Nav: '/avo',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/rus.png',
                                    title: 'Russian Slad',
                                    price: '14',
                                    Nav: '/rus',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/mash.avif',
                                    title: 'Mashroom',
                                    price: '21',
                                    Nav: '/mash',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/pie.avif',
                                    title: 'Vegan Pie',
                                    price: '19',
                                    Nav: '/pie',
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
