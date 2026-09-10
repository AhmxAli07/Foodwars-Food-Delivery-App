// ignore_for_file: prefer_final_fields, prefer_const_constructors, file_names, avoid_print, deprecated_member_use

import 'dart:math';

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';

class CardCont extends StatefulWidget {
  final VoidCallback onpress;
  const CardCont({
    super.key,
    required this.onpress,
  });

  @override
  State<CardCont> createState() => _CardContState();
}

class _CardContState extends State<CardCont> {
  TextEditingController _mailFieldController = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();

  String generateRandomCode() {
    Random random = Random();
    int code = random.nextInt(9000) + 1000; // Generates a random 4-digit code
    return code.toString();
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color cardContColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Colors.white; // Set your light theme color
      return GestureDetector(
        onTap: () {
          _showTextFieldDialog(context);
        },
        child: Container(
          margin: const EdgeInsets.only(top: 10, bottom: 10),
          width: 370,
          height: 110,
          decoration: BoxDecoration(
              color: cardContColor, borderRadius: BorderRadius.circular(20)),
          child: Row(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: Icon(
                  Icons.email,
                  size: 50,
                  color: Color(0xFF4EE489),
                ),
              ),
              Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Text(
                    'Via Email',
                    style: Theme.of(context)
                        .textTheme
                        .titleMedium!
                        .copyWith(color: Colors.grey),
                  ),
                  SizedBox(height: 5),
                  Text(
                    '...@gmail.com',
                    style: Theme.of(context).textTheme.titleMedium,
                  ),
                ],
              ),
            ],
          ),
        ),
      );
    });
  }

  Future<void> _showTextFieldDialog(BuildContext context) async {
    String generatedCode = generateRandomCode();
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Enter Gmail'),
          content: Form(
            key: formKey,
            child: TextFormField(
              validator: ((value) {
                if (value!.isEmpty) {
                  return ('Enter Email');
                }
                String pattern = r'\w+@gmail.com';
                if (!RegExp(pattern).hasMatch(value)) {
                  return 'Please Enter Valid Email Format';
                }
                return null;
              }),
              onSaved: (value) {
                _mailFieldController.text = value!;
              },
              controller: _mailFieldController,
              decoration: InputDecoration(hintText: '.... @gamil.com'),
            ),
          ),
          actions: [
            ElevatedButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            ElevatedButton(
              onPressed: () {
                if (formKey.currentState!.validate()) {
                  print('Generated Code: $generatedCode');
                  auth
                      .sendPasswordResetEmail(
                        email: _mailFieldController.text,
                      )
                      .then((value) => {
                            Fluttertoast.showToast(msg: "Check Email"),
                            Navigator.pushNamed(context, '/for'),
                          })
                      // ignore: body_might_complete_normally_catch_error
                      .catchError((e) {
                    Fluttertoast.showToast(msg: e!.message);
                  });
                }
              },
              child: Text('OK'),
            ),
          ],
        );
      },
    );
  }
}
