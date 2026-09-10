// ignore_for_file: camel_case_types, unnecessary_null_comparison, prefer_const_constructors, deprecated_member_use, unnecessary_import

import 'package:foodwars/utils/uploadimage.dart';
import 'package:foodwars/widgets/snackCart.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

import '../utils/uploadimage2.dart';
import '../widgets/CardTyCont2.dart';
import '../widgets/customApBr.dart';

class upload extends StatefulWidget {
  final FirebaseAuth _auth = FirebaseAuth.instance;
  upload({super.key});

  @override
  State<upload> createState() => _uploadState();
}

class _uploadState extends State<upload> {
  late String userid;

  @override
  void initState() {
    super.initState();
    userid = getUserId();
  }

  String getUserId() {
    final user = widget._auth.currentUser;
    if (user != null) {
      return user.uid;
    }
    return ''; // Or handle this case however appropriate for your app
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SingleChildScrollView(
        child: Column(
          children: [
            CustomUppBar(
              customText: 'Upload your Photo',
            ),
            const SizedBox(height: 40),
            picCont(
              onpress: () {
                if (userid != null) {
                  pickImage(context, userid);
                  uploadImage(context, userid);
                }
              },
              name: 'From Gallery',
              photo: 'assets/gal.png',
            ),
            const SizedBox(height: 20),
            picCont(
              onpress: () {
                if (userid != null) {
                  pick(context, userid);
                  uploadpic(context, userid);
                }
              },
              name: 'From Camera',
              photo: 'assets/cam.png',
            ),
            const SizedBox(height: 10),
            Text(
              'OR',
              style: TextStyle(fontWeight: FontWeight.w700),
            ),
            const SizedBox(height: 30),
            GestureDetector(
              onTap: () {
                final snackbar = SnackBarWidget(
                  message: 'Loged In',
                  duration: const Duration(seconds: 2),
                );
                snackbar.build(context);
                Navigator.pushReplacementNamed(context, '/nav');
              },
              child: Text(
                'Skip & Direct to Home',
                style: Theme.of(context)
                    .textTheme
                    .displayLarge!
                    .copyWith(fontSize: 25),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
