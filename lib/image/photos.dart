// ignore_for_file: camel_case_types, deprecated_member_use, prefer_const_constructors, avoid_print, use_build_context_synchronously, prefer_typing_uninitialized_variables, use_super_parameters

import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:firebase_storage/firebase_storage.dart';

class photos extends StatefulWidget {
  const photos({Key? key}) : super(key: key);

  @override
  State<photos> createState() => _photosState();
}

class _photosState extends State<photos> {
  final images = FirebaseFirestore.instance.collection('Assets');
  var imagePath;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Image'),
        actions: [
          IconButton(
            onPressed: () {
              pickImage();
            },
            icon: const Icon(Icons.download),
          ),
        ],
      ),
      body: StreamBuilder(
        stream: images.snapshots(),
        builder: (context, AsyncSnapshot<QuerySnapshot> snapshot) {
          return snapshot.hasData
              ? ListView.builder(
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (BuildContext context, int index) {
                    return SingleChildScrollView(
                      child: Column(
                        children: [
                          Padding(
                            padding: const EdgeInsets.only(top: 20),
                            child: Container(
                              width: 150,
                              height: 150,
                              decoration: BoxDecoration(
                                image: DecorationImage(
                                  image: NetworkImage(
                                    snapshot.data!.docs[index]['url'],
                                  ),
                                  fit: BoxFit.cover,
                                ),
                                borderRadius: BorderRadius.circular(150),
                              ),
                            ),
                          ),
                        ],
                      ),
                    );
                  },
                )
              : const Center(
                  child: CircularProgressIndicator(),
                );
        },
      ),
    );
  }

  Future<void> pickImage() async {
    try {
      final pickedImage =
          await ImagePicker().pickImage(source: ImageSource.gallery);

      if (pickedImage != null) {
        imagePath = pickedImage.path;
        print(imagePath);
        uploadImage();
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

  Future<void> uploadImage() async {
    try {
      final File file = File(imagePath);
      final String fileName = file.path.split('/').last;
      final destination = 'Images/$fileName';

      await FirebaseStorage.instance.ref(destination).putFile(file);
      final url =
          await FirebaseStorage.instance.ref(destination).getDownloadURL();
      print(url);

      await FirebaseFirestore.instance.collection('Assets').add({'url': url});

      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Image Uploaded Successfully'),
        ),
      );
    } catch (e) {
      print('Error uploading image: $e');
    }
  }
}
