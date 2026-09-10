// ignore_for_file: camel_case_types, deprecated_member_use, prefer_const_constructors

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../widgets/Anim_button.dart';
import '../widgets/appbar.dart';
import '../widgets/field.dart';
import '../widgets/round.dart';
import '../widgets/textfield.dart';

class register extends StatefulWidget {
  const register({super.key});

  @override
  State<register> createState() => _registerState();
}

class _registerState extends State<register> {
  bool loading = false;
  final TextEditingController username = TextEditingController();
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final usercol = FirebaseFirestore.instance.collection('user');
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        appBar: zAppBar(
          context,
          'Sign Up For Free',
          automaticallyImplyLeading: false,
        ),
        body: SingleChildScrollView(
          child: Column(
            children: [
              Center(
                child: Form(
                  key: formKey,
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Inputtext(
                            icon: Icons.person.codePoint.toString(),
                            mycontroller: username,
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return ('Enter Username');
                              }
                              return null;
                            },
                            onsubmit: (value) {},
                            keyboard: TextInputType.name,
                            hint: "Username",
                            Cursor: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: Inputtext(
                            icon: Icons.email.codePoint.toString(),
                            mycontroller: email,
                            onvalidate: (value) {
                              if (value!.isEmpty) {
                                return ('Enter Email');
                              }
                              String pattern = r'\w+@gmail.com';
                              if (!RegExp(pattern).hasMatch(value)) {
                                return 'Please Enter Valid Email Format';
                              }
                              return null;
                            },
                            onsubmit: (value) {
                              email.text = value!;
                            },
                            keyboard: TextInputType.emailAddress,
                            hint: "Email",
                            Cursor: true),
                      ),
                      Padding(
                        padding: const EdgeInsets.all(10.0),
                        child: inputext(
                          mycontroller: password,
                          onvalidate: (value) {
                            if (value!.isEmpty) {
                              return ('Enter Password');
                            }
                            return null;
                          },
                          onsubmit: (value) {
                            password.text = value!;
                          },
                          keyboard: TextInputType.visiblePassword,
                          hint: 'Password',
                          icon: Icons.lock.codePoint.toString(),
                          icons: Icons.remove_red_eye.codePoint.toString(),
                          Cursor: true,
                          obsure: true,
                          isHidden: false,
                        ),
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          SizedBox(
                            width: 10,
                          ),
                          AnimatedLikeIcon(),
                          SizedBox(
                            width: 10,
                          ),
                          const Text('Keep Me Signed in')
                        ],
                      ),
                      const SizedBox(
                        height: 15,
                      ),
                      round(
                          title: 'Create Account',
                          onpress: () {
                            if (formKey.currentState!.validate()) {
                              //If
                              setState(() {
                                loading = true;
                              });
                              auth
                                  .createUserWithEmailAndPassword(
                                      email: email.text,
                                      password: password.text)
                                  .then((value) => {
                                        usercol.doc(value.user!.uid).set({
                                          'username': username.text,
                                          'email': email.text,
                                          'uid': value.user!.uid,
                                          'status': 'unavalible'
                                        }),
                                        value.user!.updateProfile(
                                            displayName: username.text),
                                        Fluttertoast.showToast(
                                            msg: 'Sign Up Successfully'),
                                        Navigator.pushReplacementNamed(
                                            context, '/upl'),
                                        setState(() {
                                          loading = false;
                                        })
                                      })
                                  .onError((error, stackTrace) => {
                                        Fluttertoast.showToast(msg: '$error'),
                                        setState(() {
                                          loading = false;
                                        })
                                      });
                            } //if
                          }),
                      const SizedBox(
                        height: 10,
                      ),
                      InkWell(
                        onTap: () {
                          Navigator.pushNamed(context, '/login');
                        },
                        child: Text('Already have an Account',
                            style: Theme.of(context)
                                .textTheme
                                .displayLarge!
                                .copyWith(
                                    decoration: TextDecoration.underline,
                                    fontSize: 14,
                                    fontWeight: FontWeight.normal)),
                      ),
                    ],
                  ),
                ),
              ),
            ],
          ),
        ));
  }
}
