import 'dart:io';
import 'package:path/path.dart';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';

import '../utils/const/back_end_config.dart';
import '../utils/loaders/loaders.dart';

class ProfileControler extends GetxController {
  final auth = FirebaseAuth.instance;
  final firebaseFirestore = FirebaseFirestore.instance;
  var nameController = TextEditingController();
  var isLoading = false.obs;
  var imagePath = ''.obs;
  var imageLink = ''.obs;

  pickImage({context, required ImageSource imageSource}) async {
    try {
      final Pickedimage = await ImagePicker().pickImage(source: imageSource, imageQuality: 70);
      if (Pickedimage == null) return;
      imagePath.value = Pickedimage.path;
    } on PlatformException catch (e) {
      Loaders.errorSnackBar(title: 'Error', messagse: e.toString());
    }
  }

  uploadProfileImage() async {
    var fileName = basename(imagePath.value);
    var destination = 'admins/${auth.currentUser!.uid}/$fileName)';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink.value = await ref.getDownloadURL();
  }

  /// for update do in the set merge (true)..
  updateProfile({name, imgUrl}) async {
    isLoading(true);
    var store = BackEndConfig.adminsCollection.doc(auth.currentUser!.uid);
    await store.set({
      'name': name,
      'image': imgUrl,
    }, SetOptions(merge: true)).then((value) {
      isLoading(false);

      Get.back();
      Loaders.successSnackBar(title: 'Success', messagse: 'Profile Updated');
    });
  }


}
