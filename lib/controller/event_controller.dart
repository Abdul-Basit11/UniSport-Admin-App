import 'dart:convert';
import 'dart:io';
import 'package:http/http.dart' as http;
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:get/get.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path/path.dart';

import '../utils/const/back_end_config.dart';
import '../utils/loaders/loaders.dart';

class EventController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getGames();
    getAdminDetails();
    getEventField();
  }

  final eventNameController = TextEditingController();
  final eventDescriptionController = TextEditingController();
  final participantsController = TextEditingController();
  final auth = FirebaseAuth.instance;

  final eventKey = GlobalKey<FormState>();
  var allGamesList = [].obs;
  var gameName = ''.obs;
  var gameId = ''.obs;
  var isTapped = false.obs;

  // images
  var isLoading = false.obs;
  var imagePath = ''.obs;
  var imageLink = ''.obs;

  var departmentName = ''.obs;
  var adminName = ''.obs;
  var isAdminApproved = false.obs;
  var isAdminBlocked = false.obs;

  getGames() async {
    BackEndConfig.gamesCollection.snapshots().listen((QuerySnapshot snapshot) {
      for (var element in snapshot.docs) {
        allGamesList.add(element);

        update();
      }
    });
  }

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
    var destination = 'events/${auth.currentUser!.uid}/$fileName)';

    Reference ref = FirebaseStorage.instance.ref().child(destination);
    await ref.putFile(File(imagePath.value));
    imageLink.value = await ref.getDownloadURL();
  }

  /// add event
  addEvent({gameName, gameId, departmentName, eventDate, eventTime, adminName}) async {
    try {
      var eventId = BackEndConfig.eventsCollection.doc().id;
      await BackEndConfig.eventsCollection.doc(eventId).set({
        'event_id': eventId,
        'event_name': eventNameController.text.toString(),
        'event_description': eventDescriptionController.text.toString(),
        'event_image': imageLink.value,
        'event_game_name': gameName,
        'event_game_id': gameId,
        'admin_uid': FirebaseAuth.instance.currentUser!.uid,
        'departmentName': departmentName,
        'isApproved': false,
        'maximum_particiant': participantsController.text.toString(),
        'event_time': eventTime,
        'event_date': eventDate,
        'event_organizer_name': adminName,
        'isFinilized': false,
        "favourite_list": FieldValue.arrayUnion([]),
      }).then((value) async {
        Get.back();
        // send notification here
        await sendNotification('created ${eventNameController.text.toString()}');
        Loaders.successSnackBar(title: 'Success', messagse: 'Event is Added\nWait for approval from super admin');
      });
    } catch (e) {
      Loaders.errorSnackBar(title: 'Error', messagse: e.toString());
    }
  }

  Future<void> sendNotification(String content) async {
    await getAdminId();

    var headers = {
      'Authorization': 'Bearer MzFmZTM5NWEtM2NjYS00NzA3LTg0OTctOGJmZjg2YjdiYzRl',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('https://onesignal.com/api/v1/notifications'));
    request.body = json.encode({
      "app_id": "1108f2cd-f8b5-4d2f-9fcf-e42b4b9c8dd0",
      "include_player_ids": [adminPlayerID.value],
      // "include_player_ids": ["ade0858e-5c24-4115-950c-464526346bc4"],
      "contents": {"en": content}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
      print('======== NOTIFICATION SEND ==========');
    } else {
      print(response.reasonPhrase);
    }
  }

  var adminPlayerID = ''.obs;

  Future<void> getAdminId() async {
    await FirebaseFirestore.instance
        .collection('tokens')
        .doc('MKjibqDd4ASOy9dbw5itaS02xhg1')
        .get()
        .then((DocumentSnapshot documentSnapshot) {
      update();
      adminPlayerID.value = documentSnapshot.get('id');
    });
  }

  bool validateEvent(time, date) {
    if (imagePath.value == '') {
      Loaders.warningSnackBar(title: 'Warning', messagse: 'Please Select Image');
      return false;
    }
    if (eventNameController.text.isEmpty) {
      Loaders.warningSnackBar(title: 'Warning', messagse: 'Event Name is Empty');
      return false;
    }
    if (eventDescriptionController.text.isEmpty) {
      Loaders.warningSnackBar(title: 'Warning', messagse: 'Event Description is Empty');
      return false;
    }
    if (participantsController.text.isEmpty) {
      Loaders.warningSnackBar(title: 'Warning', messagse: 'Please Enter Participants');
      return false;
    }

    if (time == '') {
      Loaders.warningSnackBar(title: 'Warning', messagse: 'Please select the Start Time');
      return false;
    }
    if (date == '') {
      Loaders.warningSnackBar(title: 'Warning', messagse: 'Please select the End Time');
      return false;
    }

    return true;
  }

  getAdminDetails() {
    BackEndConfig.adminsCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      departmentName.value = documentSnapshot.get('departmentName');
      adminName.value = documentSnapshot.get('name');
      isAdminApproved.value = documentSnapshot.get('isApproved');
      isAdminBlocked.value = documentSnapshot.get('isBlocked');
    });
  }

  var isApproved = false.obs;

  getEventField() async {
    BackEndConfig.eventsCollection.snapshots().listen((
      QuerySnapshot querySnapshot,
    ) {
      for (var element in querySnapshot.docs) {
        isApproved.value = element['isApproved'];
      }
    });
  }

  getCounts() async {
    var res = Future.wait([
      //0
      BackEndConfig.eventsCollection
          .where('admin_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
          .get()
          .then((value) {
        return value.docs.length;
      }),
      BackEndConfig.gamesCollection.get().then((value) {
        return value.docs.length;
      }),
    ]);
    return res;
  }
}
