import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/utils/widgets/custom_button.dart';
import 'package:unisport_admin_app/view/home/dashboard_view/dashboard_screen.dart';

import '../utils/const/back_end_config.dart';
import '../utils/const/colors.dart';
import '../utils/const/sizes.dart';
import '../utils/helper/helper_function.dart';
import '../utils/loaders/loaders.dart';
import '../view/authentication/select_department_view/select_department_view.dart';

class SignupController extends GetxController {
  @override
  void onInit() {
    super.onInit();
    getDepartments();
  }

  final auth = FirebaseAuth.instance;
  final firestore = FirebaseFirestore.instance;
  final signUpKey = GlobalKey<FormState>();
  var isTapped = false.obs;
  var departmentName = "".obs;
  var depatrmentID = "".obs;
  var allDepartments = [].obs;
  var name = TextEditingController();

  var email = TextEditingController();

  var password = TextEditingController();

  var confirmPassword = TextEditingController();
  var isLoading = false.obs;
  var isSelected = false.obs;

  Future<void> signUp() async {
    try {
      isLoading(true);
      await FirebaseAuth.instance.createUserWithEmailAndPassword(email: email.text, password: password.text);

      await BackEndConfig.adminsCollection.doc(auth.currentUser!.uid).set({
        'uid': auth.currentUser!.uid,
        'name': name.text,
        'email': email.text,
        'password': password.text,
        'image': '',
        'isBlocked': false,
        'isApproved': false,
        'departmentName': '',
        'departmentId': '',
      }).then((value) {
        isLoading(false);
        Get.to(() => SelectDepartmentView());
        // showSelectDepartmentDialog();
        // Loaders.successSnackBar(title: 'Account Created', messagse: 'Your Account is Created Successfully 🎉');
      });

      // Get.to(
      //   () => DashboardScreen(),
      // );
    } on FirebaseAuthException catch (e) {
      isLoading(false);
      Loaders.errorSnackBar(title: 'Error', messagse: e.code.toString());
    } catch (e) {
      isLoading(false);
      Loaders.errorSnackBar(title: 'Error', messagse: 'An unexpected error occurred');
    }
  }

  getDepartments() async {
    BackEndConfig.departmentCollection.snapshots().listen((QuerySnapshot snapshot) {
      for (var element in snapshot.docs) {
        allDepartments.add(element);
        isSelected.value = element['is_selected'];
        update();
      }
    });
  }

  // void showSelectDepartmentDialog() {
  //   final controller = Get.put(SignupController());
  //   showDialog(
  //     barrierDismissible: false,
  //     context: Get.context!,
  //     builder: (context) {
  //       return Dialog(
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //         child: Card(
  //           color: AppColors.kLightOrange,
  //           child: Padding(
  //             padding: EdgeInsets.all(12.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 10.sH,
  //                 Text(
  //                   'Select Department',
  //                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
  //                 ),
  //                 SizedBox(height: 20),
  //                 Obx(() => Container(
  //                       height: 48,
  //                       width: MediaQuery.of(context).size.width,
  //                       padding: const EdgeInsets.only(left: 10),
  //                       decoration: BoxDecoration(
  //                         color: AppColors.kwhite.withOpacity(0.4),
  //                         borderRadius: BorderRadius.circular(AppSizes.md),
  //                         border: Border.all(
  //                           color: BHelperFunction.isDarkMode(context) ? AppColors.kwhite : AppColors.kGrey,
  //                         ),
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           const Icon(
  //                             Iconsax.category,
  //                             size: AppSizes.iconSm,
  //                             color: AppColors.kPrimary,
  //                           ),
  //                           SizedBox(width: 15),
  //                           Text(
  //                             controller.departmentName.value == ""
  //                                 ? "Department Name"
  //                                 : controller.departmentName.value,
  //                             style: context.textTheme.labelLarge!.copyWith(color: Colors.black),
  //                           ),
  //                           const Spacer(),
  //                           IconButton(
  //                             onPressed: () {
  //                               controller.isTapped.value = !controller.isTapped.value;
  //                             },
  //                             icon: const Icon(
  //                               Icons.arrow_drop_down,
  //                               color: AppColors.kPrimary,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     )),
  //                 Obx(() => controller.isTapped.value
  //                     ? Container(
  //                         height: 120,
  //                         width: MediaQuery.of(context).size.width,
  //                         child: Card(
  //                           elevation: 2,
  //                           color: Colors.white,
  //                           child: ListView.builder(
  //                             physics: const BouncingScrollPhysics(),
  //                             itemCount: controller.allDepartments.length,
  //                             itemBuilder: (context, i) {
  //                               return InkWell(
  //                                 onTap: () {
  //                                   controller.departmentName.value = controller.allDepartments[i]["department_name"];
  //                                   controller.depatrmentID.value = controller.allDepartments[i]["department_id"];
  //                                   controller.allDepartments[i]["is_selected"] = true;
  //                                   controller.isTapped.value = !controller.isTapped.value;
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //                                   child: Text(
  //                                     controller.allDepartments[i]["department_name"],
  //                                     style: const TextStyle(fontSize: 14, color: Colors.black),
  //                                   ),
  //                                 ),
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       )
  //                     : const SizedBox()),
  //                 20.sH,
  //                 CustomButton(
  //                   title: 'Confirm',
  //                   onPressed: () {
  //                     if (controller.departmentName.value == '') {
  //                       Loaders.warningSnackBar(title: 'Warning', messagse: 'Select Department Name');
  //                     } else {
  //                       BackEndConfig.adminsCollection.doc(auth.currentUser!.uid).set(
  //                         {
  //                           'departmentName': controller.departmentName.value,
  //                         },
  //                         SetOptions(merge: true),
  //                       ).then((value) {
  //                         Loaders.successSnackBar(
  //                             title: 'Account Created', messagse: 'Your Account is Created Successfully 🎉');
  //
  //                         Get.to(
  //                           () => const DashboardScreen(),
  //                         );
  //                       });
  //                     }
  //                   },
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
  // void showSelectDepartmentDialog() {
  //     final controller = Get.put(SignupController());
  //   showDialog(
  //     context: Get.context!,
  //     builder: (context) {
  //       return Dialog(
  //         elevation: 0,
  //         backgroundColor: Colors.transparent,
  //         child: Card(
  //           color: Colors.orange[200], // Use a color from your AppColors
  //           child: Padding(
  //             padding: const EdgeInsets.all(12.0),
  //             child: Column(
  //               mainAxisSize: MainAxisSize.min,
  //               children: [
  //                 const SizedBox(height: 10),
  //                 Text(
  //                   'Select Department',
  //                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: Colors.black),
  //                 ),
  //                 const SizedBox(height: 20),
  //                 Obx(() => Container(
  //                       height: 48,
  //                       width: MediaQuery.of(context).size.width,
  //                       padding: const EdgeInsets.only(left: 10),
  //                       decoration: BoxDecoration(
  //                         color: Colors.white.withOpacity(0.4),
  //                         borderRadius: BorderRadius.circular(10),
  //                         border: Border.all(
  //                           color: Get.isDarkMode ? Colors.white : Colors.grey,
  //                         ),
  //                       ),
  //                       child: Row(
  //                         mainAxisAlignment: MainAxisAlignment.spaceBetween,
  //                         children: [
  //                           const Icon(
  //                             Icons.category,
  //                             size: 24,
  //                             color: AppColors.kPrimary, // Use a color from your AppColors
  //                           ),
  //                           const SizedBox(width: 15),
  //                           Text(
  //                             departmentName.value.isEmpty ? "Department Name" : departmentName.value,
  //                             style: Theme.of(context).textTheme.labelLarge!.copyWith(color: Colors.black),
  //                           ),
  //                           const Spacer(),
  //                           IconButton(
  //                             onPressed: () {
  //                               isTapped.value = !isTapped.value;
  //                             },
  //                             icon: const Icon(
  //                               Icons.arrow_drop_down,
  //                               color: AppColors.kPrimary,
  //                             ),
  //                           ),
  //                         ],
  //                       ),
  //                     )),
  //                 Obx(() => isTapped.value
  //                     ? Container(
  //                         height: 120,
  //                         width: MediaQuery.of(context).size.width,
  //                         child: Card(
  //                           elevation: 2,
  //                           color: Colors.white,
  //                           child: ListView.builder(
  //                             physics: const BouncingScrollPhysics(),
  //                             itemCount: allDepartments.length,
  //                             itemBuilder: (context, i) {
  //                               var department = allDepartments[i];
  //                               return InkWell(
  //                                 onTap: () {
  //                                   departmentName.value = department["department_name"] ?? "Unknown";
  //                                   depatrmentID.value = department["department_id"] ?? "Unknown";
  //                                   department['is_selected'] = true;
  //                                   controller.isTapped.value = !controller.isTapped.value;
  //                                 },
  //                                 child: Padding(
  //                                   padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
  //                                   child: Text(
  //                                     department["department_name"] ?? "Unknown",
  //                                     style: const TextStyle(fontSize: 14, color: Colors.black),
  //                                   ),
  //                                 ),
  //                               );
  //                             },
  //                           ),
  //                         ),
  //                       )
  //                     : const SizedBox()),
  //                 const SizedBox(height: 20),
  //                 ElevatedButton(
  //                   onPressed: () {
  //                     FirebaseFirestore.instance.collection('admins').doc(FirebaseAuth.instance.currentUser!.uid).set(
  //                       {
  //                         'departmentName': departmentName.value,
  //                       },
  //                       SetOptions(merge: true),
  //                     ).then((value) {
  //                       Loaders.successSnackBar(
  //                         title: 'Account Created',
  //                         messagse: 'Your Account is Created Successfully 🎉',
  //                       );
  //
  //                       Get.to(
  //                         () => const DashboardScreen(),
  //                       );
  //                       ;
  //                     });
  //                   },
  //                   child: const Text('Sign Up'),
  //                 ),
  //               ],
  //             ),
  //           ),
  //         ),
  //       );
  //     },
  //   );
  // }
}
