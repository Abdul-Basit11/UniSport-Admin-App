import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/gestures.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:google_sign_in/google_sign_in.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/utils/widgets/custom_loaders.dart';
import 'package:unisport_admin_app/view/authentication/select_department_view/select_department_view.dart';
import 'package:unisport_admin_app/view/home/dashboard_view/dashboard_screen.dart';

import '../../../controller/signup_controller.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_string.dart';
import '../../../utils/const/sizes.dart';
import '../../../utils/helper/helper_function.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_screen_title.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/socialmedia_button.dart';
import '../login_screen/login_screen.dart';

class SignUpScreen extends StatefulWidget {
  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  // List departmentList = [
  //   'IOT',
  //   'Pschylogy',
  //   'Mathematics',
  //   'Pharmacy',
  //   'DPT',
  //   'MLT',
  // ];

  String selectedDepartment = 'IOT';
  String? _errorMessage;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Obx(
      () => CustomLoader(
        isLoading: controller.isLoading.value,
        child: Scaffold(
          body: Padding(
            padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
            child: SingleChildScrollView(
              child: Form(
                key: controller.signUpKey,
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    const SizedBox(
                      height: AppSizes.spaceBtwSection,
                    ),
                    Center(
                      child: Image.asset(
                        ImageString.splashLogo,
                        height: 150,
                      ),
                    ),
                    10.sH,
                    CustomScreenTitle(title: 'Create Account .'),
                    10.sH,
                    Text(
                      'Enter the given detail to create account',
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    40.sH,
                    CustomTextField(
                        controller: controller.name,
                        validator: (v) {
                          if (v.isEmpty) {
                            return 'Name is Empty';
                          }
                        },
                        hintText: 'Name',
                        prefixIcon: Iconsax.user_edit,
                        isPrefixIcon: true),
                    CustomTextField(
                      textInputType: TextInputType.emailAddress,
                      controller: controller.email,
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Email is Empty';
                        }
                        if (!v.contains('@')) {
                          return 'Email is not Formatted';
                        }
                      },
                      hintText: 'Email',
                      prefixIcon: Iconsax.direct_right,
                      isPrefixIcon: true,
                    ),
                    CustomTextField(
                      controller: controller.password,
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'Password is Empty';
                        }
                        if (v.length < 6) {
                          return 'Password is too weak';
                        }
                      },
                      hintText: 'Password',
                      prefixIcon: Iconsax.password_check,
                      isPrefixIcon: true,
                      obsecureText: true,
                      isPasswordField: true,
                    ),
                    CustomTextField(
                      controller: controller.confirmPassword,
                      validator: (v) {
                        if (v.isEmpty) {
                          return 'confirm Password is Empty';
                        }
                        if (controller.confirmPassword.text != controller.password.text) {
                          return 'Password Not matched';
                        }
                      },
                      hintText: 'Confirm Password',
                      prefixIcon: Iconsax.password_check,
                      isPrefixIcon: true,
                      obsecureText: true,
                      isPasswordField: true,
                    ),
                    30.sH,
                    CustomButton(
                      title: 'SignUp',
                      onPressed: () {
                        if (controller.signUpKey.currentState!.validate()) {
                          controller.signUp();
                        }
                      },
                    ),
                    20.sH,
                    Center(
                      child: Text.rich(
                        TextSpan(
                          children: [
                            TextSpan(text: 'If you are olden ,\t', style: Theme.of(context).textTheme.bodyMedium),
                            TextSpan(
                                text: 'Login',
                                recognizer: TapGestureRecognizer()..onTap = () => Get.offAll(() => LoginScreen()),
                                style: Theme.of(context)
                                    .textTheme
                                    .bodyMedium!
                                    .copyWith(fontWeight: FontWeight.bold, color: AppColors.kPrimary)),
                          ],
                        ),
                      ),
                    ),
                    20.sH,
                    Row(
                      children: [
                        const Expanded(child: Divider()),
                        8.sW,
                        const Text(
                          'OR',
                        ),
                        8.sW,
                        const Expanded(child: Divider()),
                      ],
                    ),
                    20.sH,
                    SocialMediaButton(
                      googleTapped: () {
                        _handleSignIn();
                      },
                      facebookTapped: () {},
                    ),
                    40.sH,
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }

  final FirebaseAuth _auth = FirebaseAuth.instance;
  final GoogleSignIn _googleSignIn = GoogleSignIn();
  final CollectionReference adminsCollection = FirebaseFirestore.instance.collection('admins');

  Future<void> _handleSignIn() async {
    final controller = Get.put(SignupController());
    try {
      final GoogleSignInAccount? googleUser = await _googleSignIn.signIn();
      if (googleUser != null) {
        final GoogleSignInAuthentication googleAuth = await googleUser.authentication;
        final AuthCredential credential = GoogleAuthProvider.credential(
          accessToken: googleAuth.accessToken,
          idToken: googleAuth.idToken,
        );
        final UserCredential authResult = await _auth.signInWithCredential(credential);
        final User? admin = authResult.user;
        await _storeUserData(admin);
        // if (controller.isSelected.value) {
        //   Get.to(
        //     () => DashboardScreen(),
        //   );
        // }
        // controller.showSelectDepartmentDialog();

        Get.to(
          () => SelectDepartmentView(),
        );
      }
    } catch (error) {
      print("Error signing in with Google: $error");
    }
  }

  Future<void> _storeUserData(User? admin,) async {
    if (admin != null) {
      try {
        final Map<String, dynamic> adminData = {
          'uid': admin.uid,
          'name': admin.displayName,
          'email': admin.email,
          'password': '',
          'image': '',
          'isBlocked': false,
          'isApproved': false,
          'departmentName': '',
          'departmentId': '',
        };

        await adminsCollection.doc(admin.uid).set(adminData);
      } catch (error) {
        print("Error storing user record: $error");
        // Handle error
      }
    }
  }
}
