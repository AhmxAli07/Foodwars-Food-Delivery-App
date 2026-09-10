// ignore_for_file: camel_case_types, library_private_types_in_public_api, file_names, use_super_parameters, prefer_const_constructors

import 'package:foodwars/widgets/snackCart.dart';
import 'package:flutter/material.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../widgets/customApBr.dart';
import '../widgets/round.dart';

class profilsee extends StatefulWidget {
  const profilsee({Key? key}) : super(key: key);

  @override
  _profilseeState createState() => _profilseeState();
}

class _profilseeState extends State<profilsee> {
  final FirebaseAuth _auth = FirebaseAuth.instance;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: StreamBuilder<DocumentSnapshot>(
        stream: FirebaseFirestore.instance
            .collection('user')
            .doc(_auth.currentUser?.uid)
            .snapshots(),
        builder: (context, snapshot) {
          if (!snapshot.hasData || snapshot.data == null) {
            return Text('Wait');
          }
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          final url =
              data != null && data.containsKey('url') ? data['url'] : '';
          return SingleChildScrollView(
            child: Column(
              children: [
                CustomUppBar(
                  customText: 'Profile Photo',
                ),
                const SizedBox(height: 30),
                Container(
                  width: 250,
                  height: 250,
                  decoration: BoxDecoration(
                    color: Colors.transparent,
                    borderRadius: BorderRadius.circular(20),
                  ),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(20),
                    child: CachedNetworkImage(
                      fit: BoxFit.cover,
                      imageUrl: url,
                      placeholder: (context, url) =>
                          CircularProgressIndicator(),
                      errorWidget: (context, url, error) => Icon(Icons.error),
                    ),
                  ),
                ),
                const SizedBox(height: 250),
                round(
                  title: 'Next',
                  onpress: () {
                    final snackbar = SnackBarWidget(
                      message: 'Loged In',
                      duration: const Duration(seconds: 2),
                    );
                    snackbar.build(context);
                    Navigator.pushReplacementNamed(context, '/nav');
                  },
                )
              ],
            ),
          );
        },
      ),
    );
  }
}
