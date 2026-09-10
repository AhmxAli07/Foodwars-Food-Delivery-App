// ignore_for_file: prefer_const_constructors, invalid_return_type_for_catch_error, avoid_print, use_build_context_synchronously, use_key_in_widget_constructors, non_constant_identifier_names, camel_case_types, file_names, deprecated_member_use
import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/SearchBar2.dart';
import '../widgets/SearchExpan.dart';
import '../widgets/custom.dart';
import '../widgets/snackCart.dart';

class search extends StatefulWidget {
  const search({Key? key});

  @override
  State<search> createState() => _searchState();
}

class _searchState extends State<search> {
  final Foodwars = FirebaseFirestore.instance.collection('Search');
  List search = [];
  bool hasTappedSearchBar = false;

  void searchfrom(String query) async {
    final result = await FirebaseFirestore.instance
        .collection('Search')
        .where('array', arrayContains: query)
        .get();
    setState(() {
      search = result.docs.map((e) => e.data()).toList();
    });
  }

  final cart = FirebaseFirestore.instance.collection('user');
  final _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder(
        stream: Foodwars.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return Column(
            children: [
              CustomAppBar(customText: 'Find your\nFavourite Food'),
              !hasTappedSearchBar // Check if the user has tapped on the search bar
                  ? GestureDetector(
                      onTap: () {
                        setState(() {
                          hasTappedSearchBar = true;
                        });
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(top: 17),
                        child: Column(
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(left: 10),
                              child: Text(
                                'Tap on Image To Search What you Want',
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyLarge!
                                    .copyWith(
                                        fontSize: 21,
                                        color: Color(0xFF4EE489),
                                        fontStyle: FontStyle.italic,
                                        fontWeight: FontWeight.normal),
                              ),
                            ),
                            Image.asset('assets/not.png'),
                          ],
                        ),
                      ),
                    )
                  : Padding(
                      padding:
                          EdgeInsets.symmetric(horizontal: 10, vertical: 18),
                      child: CustomSearchBarTwo(
                        onChanged: (query) {
                          searchfrom(query);
                        },
                      ),
                    ),
              Expanded(
                child: ListView.builder(
                  itemCount: search.length,
                  physics: const ScrollPhysics(),
                  itemBuilder: (BuildContext context, int index) {
                    return SearchListItem(
                      imageUrl: search[index]['image'],
                      itemName: search[index]['name'],
                      price: search[index]['price'],
                      lead: () async {
                        var newItemData = {
                          'name': search[index]['name'],
                          'image': search[index]['image'],
                          'price': search[index]['price'],
                        };
                        var cartQuery = await cart
                            .doc(_auth.currentUser!.uid)
                            .collection('cart')
                            .where('name', isEqualTo: newItemData['name'])
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
                          }).catchError((error) =>
                                  print('Error adding item to cart: $error'));
                        } else {
                          final snackbar = SnackBarWidget(
                            message: 'Already Added',
                            duration: const Duration(seconds: 2),
                          );
                          snackbar.build(context);
                        }
                      },
                    );
                  },
                ),
              ),
            ],
          );
        },
      ),
    );
  }
}
