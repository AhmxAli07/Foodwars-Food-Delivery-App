// ignore_for_file: camel_case_types, prefer_const_constructors, non_constant_identifier_names, deprecated_member_use, invalid_return_type_for_catch_error, avoid_print, use_build_context_synchronously, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../Theme/theme.dart';
import '../../widgets/Anim_icon.dart';
import '../../widgets/CartRoundB.dart';
import '../../widgets/FirebaseRow.dart';
import '../../widgets/NewText.dart';
import '../../widgets/snackCart.dart';

class beef extends StatefulWidget {
  const beef({super.key});

  @override
  State<beef> createState() => _beefState();
}

class _beefState extends State<beef> {
  final Foodwars = FirebaseFirestore.instance.collection('HealthyMenubeef');
  final cart = FirebaseFirestore.instance.collection('user');
  final fav = FirebaseFirestore.instance.collection('user');
  final _auth = FirebaseAuth.instance;
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
        body: StreamBuilder(
            stream: Foodwars.snapshots(),
            builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
              if (!snapshot.hasData) {
                return Center(child: CircularProgressIndicator());
              }
              return Stack(
                children: [
                  Positioned.fill(
                    child: Image.network(
                        snapshot.data!.docs.isNotEmpty
                            ? snapshot.data!.docs[0]['image']
                            : '',
                        fit: BoxFit.cover),
                  ),
                  Positioned.fill(
                    child: CustomScrollView(
                      slivers: [
                        SliverToBoxAdapter(
                          child: Container(height: 380),
                        ),
                        SliverList(
                          delegate: SliverChildBuilderDelegate(
                              (BuildContext context, int index) {
                            return Container(
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
                                    margin:
                                        EdgeInsets.only(top: 10, bottom: 15),
                                    width: 85,
                                    height: 5.5,
                                    decoration: BoxDecoration(
                                        color: barColor,
                                        borderRadius:
                                            BorderRadius.circular(10)),
                                  )),
                                  Row(
                                    mainAxisAlignment: MainAxisAlignment.end,
                                    children: [
                                      AnimatedHeartIcon(
                                        onTap: () async {
                                          var newItemData = {
                                            'name': snapshot.data!.docs[index]
                                                ['name'],
                                            'image': snapshot.data!.docs[index]
                                                ['image'],
                                            'price': snapshot.data!.docs[index]
                                                ['price'],
                                          };
                                          var cartQuery = await fav
                                              .doc(_auth.currentUser!.uid)
                                              .collection('Favourite')
                                              .where('name',
                                                  isEqualTo:
                                                      newItemData['name'])
                                              .get();
                                          if (cartQuery.docs.isEmpty) {
                                            await cart
                                                .doc(_auth.currentUser!.uid)
                                                .collection('Favourite')
                                                .add(newItemData)
                                                .then((_) {
                                              final snackbar = SnackBarWidget(
                                                message: 'Item Added',
                                                duration:
                                                    const Duration(seconds: 2),
                                              );
                                              snackbar.build(context);
                                            }).catchError((error) => print(
                                                    'Error adding item to cart: $error'));
                                          } else {
                                            final snackbar = SnackBarWidget(
                                              message: 'Already Added',
                                              duration:
                                                  const Duration(seconds: 2),
                                            );
                                            snackbar.build(context);
                                          }
                                        },
                                      ),
                                    ],
                                  ),
                                  MenuItemWidget(
                                    itemName: snapshot.data!.docs[index]
                                        ['name'],
                                    price: snapshot.data!.docs[index]['price'],
                                  ),
                                  SizedBox(
                                    height: 5,
                                  ),
                                  AdjustText(
                                      text:
                                          'Beef, a culinary classic, epitomizes savory indulgence with its robust flavor and tender texture. From juicy steaks to hearty burgers, it offers a versatile canvas for gastronomic exploration. Rich in essential nutrients like iron and protein, beef contributes to muscle health and vitality. Grilled, roasted, or simmered in stews, its aroma and taste evoke a timeless tradition of hearty, satisfying meals. '),
                                  SizedBox(
                                    height: 10,
                                  ),
                                  RoundButton(onpress: () async {
                                    var newItemData = {
                                      'name': snapshot.data!.docs[index]
                                          ['name'],
                                      'image': snapshot.data!.docs[index]
                                          ['image'],
                                      'price': snapshot.data!.docs[index]
                                          ['price'],
                                    };
                                    var cartQuery = await cart
                                        .doc(_auth.currentUser!.uid)
                                        .collection('cart')
                                        .where('name',
                                            isEqualTo: newItemData['name'])
                                        .get();
                                    if (cartQuery.docs.isEmpty) {
                                      await cart
                                          .doc(_auth.currentUser!.uid)
                                          .collection('cart')
                                          .add(newItemData)
                                          .then((_) {
                                        final snackbar = SnackBarWidget(
                                          message: 'Item Added',
                                          duration: const Duration(seconds: 2),
                                        );
                                        snackbar.build(context);
                                      }).catchError((error) => print(
                                              'Error adding item to cart: $error'));
                                    } else {
                                      final snackbar = SnackBarWidget(
                                        message: 'Already Added',
                                        duration: const Duration(seconds: 2),
                                      );
                                      snackbar.build(context);
                                    }
                                  })
                                ],
                              ),
                            );
                          }),
                        ),
                      ],
                    ),
                  ),
                ],
              );
            }),
      );
    });
  }
}
