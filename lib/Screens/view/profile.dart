// ignore_for_file: prefer_const_constructors, use_super_parameters, prefer_const_literals_to_create_immutables, deprecated_member_use
import 'package:foodwars/Theme/theme.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:provider/provider.dart';
import '../../widgets/Dissmisible.dart';
import '../../widgets/components/image.dart';
import '../../widgets/profileCard.dart';
import '../../widgets/profileRow.dart';

class Profile extends StatefulWidget {
  const Profile({Key? key}) : super(key: key);

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  final fav = FirebaseFirestore.instance.collection('user');

  _ProfileState();

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color containerColor = themeProvider.isDarkTheme
          ? Colors.black // Set your dark theme color
          : Colors.white; // Set your light theme color
      return Scaffold(
        body: StreamBuilder(
          stream: FirebaseFirestore.instance
              .collection('user')
              .doc(_auth.currentUser!.uid)
              .snapshots(),
          builder: (context, AsyncSnapshot<DocumentSnapshot> snapshot) {
            if (!snapshot.hasData) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            }
            final data = snapshot.data!.data() as Map<String,
                dynamic>?; // Convert to Map<String, dynamic> or nullable
            final url =
                data != null && data.containsKey('url') ? data['url'] : '';
            return Column(
              children: [
                Expanded(
                  child: Stack(
                    children: [
                      Positioned.fill(
                        child: CachedNetworkImage(
                          fit: BoxFit.cover,
                          imageUrl: url,
                          placeholder: (context, url) =>
                              CircularProgressIndicator(),
                          errorWidget: (context, url, error) =>
                              Icon(Icons.error),
                        ),
                      ),
                      Positioned.fill(
                        child: CustomScrollView(
                          slivers: [
                            SliverToBoxAdapter(
                              child: Container(
                                height: 385,
                              ),
                            ),
                            SliverList(
                              delegate: SliverChildListDelegate(
                                [
                                  Container(
                                    width: double.infinity,
                                    height: 800,
                                    decoration: BoxDecoration(
                                      color: containerColor,
                                      borderRadius: BorderRadius.only(
                                        topLeft: Radius.circular(40),
                                        topRight: Radius.circular(40),
                                      ),
                                    ),
                                    child: Column(
                                      children: [
                                        SizedBox(height: 7),
                                        Center(
                                          child: ElevatedButton(
                                            onPressed: () {
                                              String userId =
                                                  _auth.currentUser!.uid;
                                              performImageActions(context,
                                                  snapshot.data!.id, userId);
                                            },
                                            child: const Text(
                                                'Add and Update Image'),
                                          ),
                                        ),
                                        UserDataWidget(
                                          userDataStream: FirebaseFirestore
                                              .instance
                                              .collection('user')
                                              .doc(_auth.currentUser!.uid)
                                              .snapshots(),
                                        ),
                                        StreamBuilder<QuerySnapshot>(
                                          stream: FirebaseFirestore.instance
                                              .collection('user')
                                              .doc(_auth.currentUser!.uid)
                                              .collection('Favourite')
                                              .snapshots(),
                                          builder: (context, snapshot) {
                                            if (!snapshot.hasData) {
                                              return const Center(
                                                child:
                                                    CircularProgressIndicator(),
                                              );
                                            }
                                            return ListView.builder(
                                              shrinkWrap: true,
                                              itemCount:
                                                  snapshot.data!.docs.length,
                                              itemBuilder: (context, index) {
                                                final cartItem =
                                                    snapshot.data!.docs[index];
                                                return Dismissible(
                                                  key: GlobalKey(),
                                                  background: Dissmissable(),
                                                  onDismissed: (direction) {
                                                    setState(() {
                                                      // Delete the dismissed item
                                                      fav
                                                          .doc(_auth
                                                              .currentUser!.uid)
                                                          .collection(
                                                              'Favourite')
                                                          .doc(cartItem.id)
                                                          .delete();
                                                    });
                                                  },
                                                  child: ProfileProductCard(
                                                    name: cartItem['name'],
                                                    price:
                                                        "\$${cartItem['price']}",
                                                    imageUrl: cartItem['image'],
                                                  ),
                                                );
                                              },
                                            );
                                          },
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
            );
          },
        ),
      );
    });
  }
}
