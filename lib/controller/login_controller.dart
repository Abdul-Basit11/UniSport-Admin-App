import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unisport_admin_app/view/home/dashboard_view/dashboard_screen.dart';

import '../utils/exception/firebaseauth_exception.dart';
import '../utils/loaders/loaders.dart';

class LoginController extends GetxController {
  var isLoading = false.obs;
  final localStorage = GetStorage();
  final _auth = FirebaseAuth.instance;
  final loginKey = GlobalKey<FormState>();

  // text controller
  final email = TextEditingController();
  final password = TextEditingController();

  // functions
  Future<void> login() async {
    try {
      isLoading(true);

      await _auth.signInWithEmailAndPassword(email: email.text, password: password.text).then((value) {
        isLoading(false);
        Get.offAll(
          () => DashboardScreen(),
        );

        Loaders.successSnackBar(title: 'Login Successfully', messagse: value.user!.email.toString());
      }).onError((error, stackTrace) {
        isLoading(false);
        Loaders.errorSnackBar(title: 'Error', messagse: error.toString());
      });
    } on FirebaseAuthException catch (e) {
      throw BFirebaseAuthException(e.code).message;
    }
  }

  Future<void> sendEmailResetPassword(String email) async {
    try {
      await _auth.sendPasswordResetEmail(email: email);
      Get.back();
    } on FirebaseAuthException catch (e) {
      Loaders.errorSnackBar(title: e.message.toString());
    } on FirebaseException catch (e) {
      Loaders.errorSnackBar(title: e.message.toString());
    } catch (e) {
      Loaders.errorSnackBar(title: e.toString());
    }
  }
}
