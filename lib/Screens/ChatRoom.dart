// ignore_for_file: file_names, camel_case_types, prefer_const_constructors, unnecessary_null_comparison, avoid_print, sized_box_for_whitespace, use_key_in_widget_constructors

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../Theme/theme.dart';

class chatroom extends StatelessWidget {
  final Map<String, dynamic> userMap;
  final String chatid;

  chatroom({required this.userMap, required this.chatid});

  final FirebaseFirestore firestore = FirebaseFirestore.instance;
  final TextEditingController message = TextEditingController();
  final FirebaseAuth auth = FirebaseAuth.instance;

  void onSendMessage() async {
    if (message.text.isNotEmpty) {
      Map<String, dynamic> messages = {
        "sendby": auth.currentUser!.displayName,
        "message": message.text,
        "type": "text",
        "time": FieldValue.serverTimestamp(),
      };
      message.clear();
      await firestore
          .collection('chatroom')
          .doc(chatid)
          .collection('chats')
          .add(messages);
    } else {
      print("Enter Some Text");
    }
  }

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color textColor = themeProvider.isDarkTheme ? Colors.white : Colors.black;
      return Scaffold(
        appBar: AppBar(
          title: StreamBuilder<DocumentSnapshot>(
            stream:
                firestore.collection("user").doc(userMap['uid']).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data != null) {
                return Column(
                  children: [
                    Text(userMap['username']),
                    Text(
                      snapshot.data!['status'],
                      style: TextStyle(fontSize: 14),
                    ),
                  ],
                );
              } else {
                return Container();
              }
            },
          ),
        ),
        body: Column(
          children: [
            // CustomChatUppBar(
            //   customText: userMap['username'], userMap: {},

            // ),
            Expanded(
              child: StreamBuilder<QuerySnapshot>(
                stream: firestore
                    .collection('chatroom')
                    .doc(chatid)
                    .collection("chats")
                    .orderBy("time", descending: false)
                    .snapshots(),
                builder: (BuildContext context,
                    AsyncSnapshot<QuerySnapshot> snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  }
                  if (snapshot.hasError) {
                    return Text('Error: ${snapshot.error}');
                  }
                  if (snapshot.hasData) {
                    return ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      itemBuilder: (context, index) {
                        Map<String, dynamic> map = snapshot.data!.docs[index]
                            .data() as Map<String, dynamic>;
                        return messages(context, map, textColor);
                      },
                    );
                  } else {
                    return Center(child: CircularProgressIndicator());
                  }
                },
              ),
            ),
            Padding(
              padding: EdgeInsets.only(left: 15, bottom: 10),
              child: Row(
                children: [
                  Expanded(
                    child: TextFormField(
                      controller: message,
                      decoration: InputDecoration(
                          hintText: 'Enter your message...',
                          border: OutlineInputBorder()),
                    ),
                  ),
                  IconButton(
                    onPressed: onSendMessage,
                    icon: Icon(
                      Icons.send,
                      color: Color(0xFF4EE489),
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      );
    });
  }

  Widget messages(
      BuildContext context, Map<String, dynamic> map, Color textColor) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 3),
      child: Align(
        alignment: map["sendby"] == auth.currentUser!.displayName
            ? Alignment.centerRight
            : Alignment.centerLeft,
        child: Container(
          constraints: BoxConstraints(
            maxWidth: MediaQuery.of(context).size.width * 0.7,
          ),
          padding: EdgeInsets.all(8),
          margin: EdgeInsets.symmetric(vertical: 4),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.only(
                topRight: Radius.circular(15),
                bottomRight: Radius.circular(0),
                topLeft: Radius.circular(15),
                bottomLeft: Radius.circular(15)),
            color: map["sendby"] == auth.currentUser!.displayName
                ? Color(0xFF4EE489)
                : Colors.grey,
          ),
          child: Text(
            map['message'],
            style: TextStyle(
              fontSize: 16,
              fontWeight: FontWeight.w500,
              color: textColor,
            ),
          ),
        ),
      ),
    );
  }
}
