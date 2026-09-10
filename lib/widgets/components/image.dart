// ignore_for_file: avoid_web_libraries_in_flutter, prefer_typing_uninitialized_variables, avoid_print, prefer_const_constructors, use_build_context_synchronously
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

Future<void> performImageActions(
    BuildContext context, String documentId, String userId) async {
  try {
    final pickedImage =
        await ImagePicker().pickImage(source: ImageSource.gallery);
    if (pickedImage != null) {
      var imagePath = pickedImage.path;
      print(imagePath);
      final File file = File(imagePath);
      final String fileName = file.path.split('/').last;
      final destination = 'Images/$fileName';
      await FirebaseStorage.instance.ref(destination).putFile(file);
      final url =
          await FirebaseStorage.instance.ref(destination).getDownloadURL();
      print(url);
      await FirebaseFirestore.instance.collection('user').doc(userId).update({
        'url': url,
      });
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image Picked and Updated Successfully'),
        ),
      );
    } else {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Permission denied or no image picked.'),
        ),
      );
    }
  } catch (e) {
    print('Error performing image actions: $e');
  }
}
