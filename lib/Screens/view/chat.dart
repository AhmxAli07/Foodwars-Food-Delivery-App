// ignore_for_file: camel_case_types, file_names, avoid_print, prefer_const_constructors, deprecated_member_use, use_key_in_widget_constructors

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import '../../Theme/theme.dart';
import '../../widgets/custom.dart';
import '../ChatRoom.dart';

class chat extends StatefulWidget {
  const chat({Key? key});

  @override
  State<chat> createState() => _chatState();
}

class _chatState extends State<chat> with WidgetsBindingObserver {
  final FirebaseAuth auth = FirebaseAuth.instance;
  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController search = TextEditingController();
  bool isloading = false;
  late Map<String, dynamic> userMap = {};

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addObserver(this);
    setStatus("Online");
  }

  void setStatus(String status) async {
    await firestore.collection('user').doc(auth.currentUser!.uid).update({
      "status": status,
    });
  }

  @override
  void didChangeAppLifecycleState(AppLifecycleState state) {
    if (state == AppLifecycleState.resumed) {
      setStatus("Online");
    } else {
      setStatus("Offline");
    }
  }

  void onsearch() async {
    FirebaseFirestore firestore = FirebaseFirestore.instance;
    setState(() {
      isloading = true;
    });
    await firestore
        .collection('user')
        .where('email', isEqualTo: search.text)
        .get()
        .then((emailQuerySnapshot) async {
      if (emailQuerySnapshot.docs.isEmpty) {
        await firestore
            .collection('user')
            .where('username', isEqualTo: search.text)
            .get()
            .then((usernameQuerySnapshot) {
          setState(() {
            if (usernameQuerySnapshot.docs.isNotEmpty) {
              userMap = usernameQuerySnapshot.docs[0].data();
            } else {
              userMap = {}; // Reset userMap if no matching document found
            }
            isloading = false;
          });
          print(userMap);
        });
      } else {
        setState(() {
          userMap = emailQuerySnapshot.docs[0].data();
          isloading = false;
        });
        print(userMap);
      }
    });
  }

  String chatid(String user1, String user2) {
    if (user1.isNotEmpty && user2.isNotEmpty) {
      int user1Ascii = user1[0].toLowerCase().codeUnits[0];
      int user2Ascii = user2[0].toLowerCase().codeUnits[0];
      if (user1Ascii > user2Ascii) {
        return "$user1$user2";
      } else {
        return "$user2$user1";
      }
    } else {
      return ""; // You can return a default value or handle the scenario differently
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color cardColor = themeProvider.isDarkTheme
          ? Color(0xFF252525) // Set your dark theme color
          : Colors.white; // Set your light theme color
      return Scaffold(
        body: isloading
            ? const Center(
                child: CircularProgressIndicator(),
              )
            : Column(children: [
                CustomAppBar(
                  customText: 'Chat',
                ),
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 13, vertical: 20),
                  child: Row(
                    children: [
                      Expanded(
                        child: TextField(
                          controller: search,
                          decoration:
                              InputDecoration(border: OutlineInputBorder()),
                        ),
                      ),
                      IconButton(
                        onPressed: onsearch,
                        icon: const Icon(
                          Icons.search,
                          color: Color(0xFF4EE489),
                        ),
                      ),
                    ],
                  ),
                ),
                userMap.isNotEmpty
                    ? Card(
                        shadowColor: cardColor,
                        surfaceTintColor: cardColor,
                        color: cardColor,
                        child: ListTile(
                          onTap: () {
                            String currentUserDisplayName =
                                auth.currentUser?.displayName ?? '';
                            String roomid = chatid(
                                currentUserDisplayName, userMap['username']);
                            Navigator.of(context).push(MaterialPageRoute(
                              builder: (_) => chatroom(
                                chatid: roomid,
                                userMap: userMap,
                              ),
                            ));
                          },
                          title: Text(userMap['username'] ?? ''),
                          subtitle: Text(userMap['email'] ?? 'No Email'),
                        ),
                      )
                    : Text(
                        "Search With Email or Username",
                        style: Theme.of(context).textTheme.displayLarge!.copyWith(
                              fontSize: 16,
                              fontWeight: FontWeight.normal,
                            ),
                      ),
              ]),
      );
    });
  }
}
