// ignore_for_file: camel_case_types, unused_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import '../../widgets/Card.dart';
import '../../widgets/Dissmisible.dart';
import '../../widgets/badge.dart';
import '../../widgets/custom.dart';

class cart extends StatefulWidget {
  const cart({super.key});

  @override
  State<cart> createState() => _cartState();

  void updateBadgeCount(int i) {}
}

class _cartState extends State<cart> {
  final cart = FirebaseFirestore.instance.collection('user');
  final _auth = FirebaseAuth.instance;
  int cartBadgeCount = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: StreamBuilder(
      stream: cart.doc(_auth.currentUser!.uid).collection('cart').snapshots(),
      builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
        if (snapshot.hasError) {
          return ErrorWidget(snapshot.error.toString());
        }
        return Column(
          children: [
            CustomAppBar(
              customText: 'Order\nDetails',
            ),
            !snapshot.hasData
                ? const CircularProgressIndicator()
                : Expanded(
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        return Dismissible(
                          key: GlobalKey(),
                          background: const Dissmissable(),
                          onDismissed: (d) {
                            cart
                                .doc(_auth.currentUser!.uid)
                                .collection('cart')
                                .doc(snapshot.data!.docs[index].id)
                                .delete();
                          },
                          child: CustomProductCard(
                            resto: 'Restaurant',
                            name: snapshot.data!.docs[index]['name'],
                            price: "\$${snapshot.data!.docs[index]['price']}",
                            imageUrl: snapshot.data!.docs[index]['image'],
                          ),
                        );
                      },
                    ),
                  ),
          ],
        );
      },
    ));
  }
}
