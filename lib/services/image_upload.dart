import 'dart:io';

import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';

class ImageUpload {
  Future<String> uploadImage(BuildContext context, {required File file,required String folderName}) async {
    late String imageURL;
    try {
      Reference ref = FirebaseStorage.instance.ref().child("$folderName/${file.path.split('/').last}");

      UploadTask uploadTask = ref.putFile(file);

      await uploadTask.whenComplete(() async {
        await ref.getDownloadURL().then((url) {
          imageURL = url;
        });
      });
      return imageURL;
    } catch (e) {
      rethrow;
    }
  }


}
