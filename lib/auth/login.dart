// ignore_for_file: camel_case_types, unnecessary_import, deprecated_member_use, prefer_const_constructors, sized_box_for_whitespace
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:foodwars/widgets/appbar.dart';
import 'package:foodwars/widgets/field.dart';
import 'package:foodwars/widgets/round.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';
import '../widgets/components/facebook.dart';
import '../widgets/components/google.dart';

class login extends StatefulWidget {
  const login({super.key});
  @override
  State<login> createState() => _loginState();
}

class _loginState extends State<login> {
  bool loading = false;
  final TextEditingController password = TextEditingController();
  final TextEditingController email = TextEditingController();
  final GlobalKey<FormState> formKey = GlobalKey<FormState>();
  final FirebaseAuth auth = FirebaseAuth.instance;
  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color containerColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Colors.white; // Set your light theme color
      return Scaffold(
          appBar: zAppBar(
            automaticallyImplyLeading: false,
            context,
            'Login To Your Account',
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
                          child: Inputtext(
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
                              keyboard: TextInputType.emailAddress,
                              hint: "Password",
                              Cursor: true),
                        ),
                        Row(
                          mainAxisAlignment: MainAxisAlignment.end,
                          children: [
                            Padding(
                              padding: const EdgeInsets.only(right: 10),
                              child: InkWell(
                                onTap: () {
                                  Navigator.pushNamed(context, "/for");
                                },
                                child: Text("Forget Password",
                                    style: Theme.of(context)
                                        .textTheme
                                        .displayLarge!
                                        .copyWith(
                                            fontSize: 17,
                                            decoration:
                                                TextDecoration.underline)),
                              ),
                            ),
                          ],
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Text(
                          'Or Continue With',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        SizedBox(
                          height: 10,
                        ),
                        Padding(
                          padding: const EdgeInsets.all(5.0),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.spaceAround,
                            children: [
                              InkWell(
                                onTap: () {
                                  FacebookLogin(context);
                                },
                                child: Container(
                                  width: 155,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: containerColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset("assets/facebook.png"),
                                      Text('Facebook'),
                                    ],
                                  ),
                                ),
                              ),
                              InkWell(
                                onTap: () {
                                  signInWithGoogle(context);
                                },
                                child: Container(
                                  width: 155,
                                  height: 60,
                                  decoration: BoxDecoration(
                                      color: containerColor,
                                      borderRadius: BorderRadius.circular(10)),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceEvenly,
                                    children: [
                                      Image.asset("assets/google.png"),
                                      Text('Google'),
                                    ],
                                  ),
                                ),
                              )
                            ],
                          ),
                        ),
                        SizedBox(
                          height: 20,
                        ),
                        round(
                            title: 'Login',
                            onpress: () {
                              if (formKey.currentState!.validate()) {
                                //if
                                setState(() {
                                  loading = true;
                                });
                                auth
                                    .signInWithEmailAndPassword(
                                        email: email.text,
                                        password: password.text)
                                    .then((value) => {
                                          Fluttertoast.showToast(
                                              msg: "Login Successful"),
                                          Navigator.pushReplacementNamed(
                                              context, '/nav'),
                                          setState(() {
                                            loading = false;
                                          })
                                        })
                                    // ignore: body_might_complete_normally_catch_error
                                    .catchError((e) {
                                  Fluttertoast.showToast(msg: e!.message);
                                  setState(() {
                                    loading = false;
                                  });
                                });
                              } //if
                            }),
                        SizedBox(
                          height: 3,
                        ),
                        InkWell(
                          onTap: () {
                            Navigator.pushNamed(context, '/reg');
                          },
                          child: Text('Sign up for free',
                              style: Theme.of(context)
                                  .textTheme
                                  .displayLarge!
                                  .copyWith(
                                      fontStyle: FontStyle.italic,
                                      fontSize: 16,
                                      fontWeight: FontWeight.w900)),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ),
          ));
    });
  }
}
