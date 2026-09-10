// import 'package:flutter/material.dart';
// import 'package:cloud_firestore/cloud_firestore.dart';

// class SearchUserWidget extends StatefulWidget {
//   const SearchUserWidget({Key? key}) : super(key: key);

//   @override
//   _SearchUserWidgetState createState() => _SearchUserWidgetState();
// }

// class _SearchUserWidgetState extends State<SearchUserWidget> {
//   final TextEditingController search = TextEditingController();
//   bool isloading = false;
//   late Map<String, dynamic> userMap = {};

//   void onSearch() async {
//     FirebaseFirestore firestore = FirebaseFirestore.instance;
//     setState(() {
//       isloading = true;
//     });

//     await firestore.collection('user').where('email', isEqualTo: search.text).get().then((emailQuerySnapshot) async {
//       if (emailQuerySnapshot.docs.isEmpty) {
//         // If no user found with email, search by username
//         await firestore.collection('user').where('username', isEqualTo: search.text).get().then((usernameQuerySnapshot) {
//           setState(() {
//             if (usernameQuerySnapshot.docs.isNotEmpty) {
//               userMap = usernameQuerySnapshot.docs[0].data();
//             } else {
//               userMap = {}; // Reset userMap if no matching document found
//             }
//             isloading = false;
//           });
//           print(userMap);
//         });
//       } else {
//         setState(() {
//           userMap = emailQuerySnapshot.docs[0].data();
//           isloading = false;
//         });
//         print(userMap);
//       }
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     return Column(
//       mainAxisAlignment: MainAxisAlignment.center,
//       children: [
//         TextField(
//           controller: search,
//         ),
//         IconButton(
//           onPressed: onSearch,
//           icon: const Text('Search'),
//         ),
//         isloading
//             ? const Center(
//                 child: CircularProgressIndicator(),
//               )
//             : userMap.isNotEmpty
//                 ? ListTile(
//                     title: Text(userMap['username'] ?? ''),
//                     subtitle: Text(userMap['email'] ?? 'No Email'),
//                   )
//                 : const Text('No data found'),
//       ],
//     );
//   }
// }
