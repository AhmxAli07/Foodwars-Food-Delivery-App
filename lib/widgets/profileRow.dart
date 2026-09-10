// ignore_for_file: use_super_parameters, file_names, prefer_const_constructors, deprecated_member_use, avoid_print, prefer_const_literals_to_create_immutables, unused_local_variable, use_build_context_synchronously

import 'package:flutter/material.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:provider/provider.dart';

import '../Theme/theme.dart';

class UserDataWidget extends StatelessWidget {
  final Stream<DocumentSnapshot> userDataStream;
  final FirebaseAuth _auth = FirebaseAuth.instance;
  UserDataWidget({
    Key? key,
    required this.userDataStream,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(builder: (context, themeProvider, child) {
      Color contColor =
          themeProvider.isDarkTheme ? Color(0xFF251D0F) : Color(0xFFfcac1e);
      Color textColor =
          themeProvider.isDarkTheme ? Color(0xFFDA6317) : Color(0xFFFFF7E8);
      return StreamBuilder<DocumentSnapshot>(
        stream: userDataStream,
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return CircularProgressIndicator();
          }
          if (!snapshot.hasData || snapshot.data == null) {
            return Text("No data available");
          }
          final data = snapshot.data!.data() as Map<String, dynamic>?;
          final username = data != null && data.containsKey('username')
              ? data['username']
              : '';
          final email =
              data != null && data.containsKey('email') ? data['email'] : '';
          return Column(
            children: [
              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () {
                        _showUpdateUsernameDialog(context, username);
                      },
                      child: Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 10),
                        child: Text(
                          username ?? '',
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(fontSize: 24),
                        ),
                      ),
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      _showUpdateUsernameDialog(context, username);
                    },
                    icon: Icon(
                        size: 35,
                        Icons.create_outlined,
                        color: Color(0xFF4EE489)),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    child: Text(
                      email ?? '',
                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                          fontStyle: FontStyle.italic, color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Padding(
                    padding: const EdgeInsets.only(right: 5),
                    child: InkWell(
                      onTap: () async {
                        await _auth.signOut();
                        Navigator.pushNamed(context, '/login');
                      },
                      child: Padding(
                        padding: const EdgeInsets.only(right: 10),
                        child: Container(
                          width: 75,
                          height: 30,
                          decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(30),
                              color: contColor),
                          child: Center(
                              child: Text(
                            "Logout",
                            style: Theme.of(context)
                                .textTheme
                                .displayMedium!
                                .copyWith(fontSize: 14, color: textColor),
                          )),
                        ),
                      ),
                    ),
                  ),
                ],
              ),
              Row(
                children: [
                  Padding(
                    padding: const EdgeInsets.symmetric(
                      horizontal: 15,
                    ),
                    child: Text(
                      'Favourite',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          fontSize: 17, fontWeight: FontWeight.normal),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      );
    });
  }

  void _showUpdateUsernameDialog(
      BuildContext context, String? currentUsername) {
    TextEditingController usernameController =
        TextEditingController(text: currentUsername);
    showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          title: Text('Update Username'),
          content: TextField(
            controller: usernameController,
            decoration: InputDecoration(
              labelText: 'New Username',
            ),
          ),
          actions: [
            TextButton(
              onPressed: () {
                Navigator.pop(context);
              },
              child: Text('Cancel'),
            ),
            TextButton(
              onPressed: () {
                String newUsername = usernameController.text;
                _updateUsername(newUsername);
                Navigator.pop(context);
              },
              child: Text('Update'),
            ),
          ],
        );
      },
    );
  }

  Future<void> _updateUsername(String newUsername) async {
    try {
      final currentUser = _auth.currentUser;
      if (currentUser != null) {
        await FirebaseFirestore.instance
            .collection('user')
            .doc(currentUser.uid)
            .update({'username': newUsername});
      }
    } catch (error) {
      print('Failed to update username: $error');
    }
  }
}
