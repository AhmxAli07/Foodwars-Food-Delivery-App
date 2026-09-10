// ignore_for_file: non_constant_identifier_names, unused_import, file_names, prefer_const_constructors, deprecated_member_use, use_super_parameters

import 'package:foodwars/widgets/NewRow.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';
import '../widgets/cont.dart';
import '../widgets/customText.dart';
import '../widgets/row.dart';

class SmartResto extends StatefulWidget {
  const SmartResto({Key? key}) : super(key: key);

  @override
  State<SmartResto> createState() => _SmartRestoState();
}

class _SmartRestoState extends State<SmartResto> {
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
              "assets/taurant.avif",
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
                                    'Smart Foods',
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
                                  'Smart food, a contemporary concept, refers to food products designed to enhance cognitive function, and long-term health. These foods often incorporate nutrient-dense ingredients such as omega-3 fatty acids, antioxidants, and vitamins known to support brain health.Smart food choices also consider sustainable and  addressing both personal health and environmental impact.',
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
                                    imagepath: 'assets/ice.png',
                                    title: 'Ice Cream',
                                    price: '6',
                                    Nav: '/ic',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/piz.png',
                                    title: 'Pizza',
                                    price: '77',
                                    Nav: '/p',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/buf.png',
                                    title: 'Buffet',
                                    price: '123',
                                    Nav: '/buf',
                                  ),
                                  CustomContainer(
                                    imagepath: 'assets/corn.avif',
                                    title: 'Corn',
                                    price: '2',
                                    Nav: '/co',
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
