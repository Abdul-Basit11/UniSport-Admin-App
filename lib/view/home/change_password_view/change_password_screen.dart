import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';


import '../../../utils/const/back_end_config.dart';
import '../../../utils/const/image_string.dart';
import '../../../utils/const/sizes.dart';
import '../../../utils/helper/helper_function.dart';
import '../../../utils/loaders/loaders.dart';
import '../../../utils/validators/validators.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_loaders.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../authentication/login_screen/login_screen.dart';

class ChangePasswordScreen extends StatefulWidget {
  const ChangePasswordScreen({super.key});

  @override
  State<ChangePasswordScreen> createState() => _ChangePasswordScreenState();
}

class _ChangePasswordScreenState extends State<ChangePasswordScreen> {
  final auth = FirebaseAuth.instance;
  TextEditingController _oldPasswordController = TextEditingController();
  TextEditingController _newPasswordController = TextEditingController();
  final _key = GlobalKey<FormState>();
  String? adminPassword;
  // change password function
  Future<void> _changePassword(BuildContext context) async {
    makeLoadingTrue();
    try {
      User? user = FirebaseAuth.instance.currentUser;

      AuthCredential credential =
          EmailAuthProvider.credential(email: user!.email.toString(), password: _oldPasswordController.text);
      await user.reauthenticateWithCredential(credential);

      await user.updatePassword(_newPasswordController.text);

      FirebaseFirestore firestore = FirebaseFirestore.instance;
      DocumentReference userDocRef = firestore.collection('users').doc(user.uid);
      await userDocRef.update({'password': _newPasswordController.text}).then((value) {
        makeLoadingFalse();
        Get.offAll(() => LoginScreen());
        Loaders.successSnackBar(title: "Success", messagse: 'Password changed successfully.');
      });
    } catch (error) {
      makeLoadingFalse();
      Loaders.successSnackBar(title: "Failed.", messagse: 'Failed to change password. ${error.toString()}');
    }
  }

  bool isLoading = false;

  makeLoadingTrue() {
    setState(() {
      isLoading = true;
    });
  }

  makeLoadingFalse() {
    setState(() {
      isLoading = false;
    });
  }

  getCurrentUser() {
    BackEndConfig.adminsCollection.doc(auth.currentUser!.uid).snapshots().listen(
      (DocumentSnapshot snapshot) {
        adminPassword = snapshot.get('password');
        setState(() {});
      },
    );
    setState(() {});
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text(
            'Change Password',
            style: Theme.of(context).textTheme.titleMedium,
          ),
        ),
        body: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: Form(
              key: _key,
              child: Column(
                children: [
                  10.sH,
                  Image.asset(
                    ImageString.changePassword,
                    height: BHelperFunction.screenHeight() * 0.35,
                  ),
                  15.sH,
                  CustomTextField(
                    controller: _oldPasswordController,
                    validator: (v) {
                      if (v.isEmpty) {
                        return 'Password is Empty';
                      } else if (_oldPasswordController.text != adminPassword.toString()) {
                        return 'Password Must be same';
                      }
                    },
                    hintText: 'Old Password',
                    isPrefixIcon: true,
                    prefixIcon: Iconsax.password_check,
                    isPasswordField: true,
                    obsecureText: true,
                  ),
                  CustomTextField(
                    controller: _newPasswordController,
                    validator: (v) => Validators.validatePassword(v),
                    hintText: 'New Password',
                    isPrefixIcon: true,
                    prefixIcon: Iconsax.password_check,
                    obsecureText: true,
                    isPasswordField: true,
                  ),
                  30.sH,
                  CustomButton(
                    title: 'Update',
                    onPressed: () {
                      if (_key.currentState!.validate()) {
                        _changePassword(context);
                      }
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
