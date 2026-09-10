// ignore_for_file: avoid_print, use_build_context_synchronously, prefer_const_constructors

import 'dart:io';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import '../auth/profileSEE.dart';

late String imagePath;

Future<void> pickImage(BuildContext context, String userId) async {
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);

    if (pickedImage != null) {
      imagePath = pickedImage.path;
      print(imagePath);
      await uploadImage(context, userId);
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission denied. Please allow access to photos.'),
        ),
      );
    }
  } catch (e) {
    print('Error picking image: $e');
  }
}

Future<void> uploadImage(BuildContext context, String userId) async {
  try {
    final File file = File(imagePath);
    final String fileName = file.path.split('/').last;
    final destination = 'Images/$fileName';

    await FirebaseStorage.instance.ref(destination).putFile(file);
    final url =
        await FirebaseStorage.instance.ref(destination).getDownloadURL();
    print(url);

    await FirebaseFirestore.instance.collection('user').doc(userId).set(
      {
        'url': url,
      },
      SetOptions(merge: true),
    );

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text('Image Uploaded Successfully'),
      ),
    );
    Navigator.of(context).pushReplacement(
      MaterialPageRoute(
        builder: (context) =>
            profilsee(), // Replace NewScreen with your desired screen
      ),
    );
  } catch (e) {
    print('Error uploading image: $e');
  }
}
