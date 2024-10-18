import 'dart:convert';

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/controller/signup_controller.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:http/http.dart' as http;
import '../../../utils/const/back_end_config.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/helper/helper_function.dart';
import '../../../utils/loaders/loaders.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../home/dashboard_view/dashboard_screen.dart';

class SelectDepartmentView extends StatefulWidget {
  SelectDepartmentView({super.key});

  @override
  State<SelectDepartmentView> createState() => _SelectDepartmentViewState();
}

class _SelectDepartmentViewState extends State<SelectDepartmentView> {
  final auth = FirebaseAuth.instance;

  @override
  void initState() {
    super.initState();
    getAdminId();
    getCurrentAdmin();
  }

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(SignupController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        elevation: 0,
        backgroundColor: Colors.transparent,
      ),
      body: Padding(
        padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
        child: SingleChildScrollView(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(
                height: AppSizes.spaceBtwSection * 2,
              ),
              Text(
                'Select Department Name',
                style: Theme.of(context).textTheme.titleMedium,
              ),
              30.sH,
              Obx(
                () => Container(
                  height: 48,
                  width: MediaQuery.of(context).size.width,
                  padding: const EdgeInsets.only(left: 10),
                  decoration: BoxDecoration(
                    color: AppColors.kwhite.withOpacity(0.4),
                    borderRadius: BorderRadius.circular(AppSizes.md),
                    border: Border.all(
                      color: BHelperFunction.isDarkMode(context) ? AppColors.kwhite : AppColors.kGrey,
                    ),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      const Icon(
                        Iconsax.category,
                        size: AppSizes.iconSm,
                      ),
                      15.sW,
                      Text(controller.departmentName.value == "" ? "Department Name" : controller.departmentName.value,
                          style: context.textTheme.labelLarge),
                      const Spacer(),
                      IconButton(
                        onPressed: () {
                          controller.isTapped.value = !controller.isTapped.value;
                        },
                        icon: const Icon(
                          Icons.arrow_drop_down,
                          color: AppColors.kPrimary,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              Obx(
                () => controller.isTapped.value
                    ? Container(
                        height: 120,
                        width: MediaQuery.of(context).size.width,
                        child: Card(
                          elevation: 2,
                          color: Colors.white,
                          child: ListView.builder(
                              physics: const BouncingScrollPhysics(),
                              itemCount: controller.allDepartments.length,
                              itemBuilder: (context, i) {
                                return InkWell(
                                    onTap: () {
                                      controller.departmentName.value = controller.allDepartments[i]["department_name"];
                                      controller.depatrmentID.value = controller.allDepartments[i]["department_id"];
                                      // controller.isSelected.value=true;
                                      FirebaseFirestore.instance
                                          .collection('departments')
                                          .doc(controller.depatrmentID.value)
                                          .set({'is_selected': true}, SetOptions(merge: true));
                                      controller.isTapped.value = !controller.isTapped.value;
                                    },
                                    child: Padding(
                                      padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                      child: Obx(
                                        () => Text(
                                          controller.allDepartments[i]["department_name"],
                                          style: const TextStyle(fontSize: 14, color: Colors.black),
                                        ),
                                      ),
                                    ));
                              }),
                        ),
                      )
                    : const SizedBox(),
              ),
              40.sH,
              CustomButton(
                title: 'Confirm',
                onPressed: () {
                  controller.isLoading(true);
                  if (controller.departmentName.value == '') {
                    Loaders.warningSnackBar(title: 'Warning', messagse: 'Select Department Name');
                  } else {
                    BackEndConfig.adminsCollection.doc(auth.currentUser!.uid).set(
                      {
                        'departmentName': controller.departmentName.value,
                        'departmentId': controller.depatrmentID.value,
                      },
                      SetOptions(merge: true),
                    ).then((value) async {
                      await sendNotification('${adminName.toString()} created an account take a look 👀');

                      Loaders.successSnackBar(
                          title: 'Account Created',
                          messagse: 'Your Account is Created Successfully 🎉\nWait for Approval');

                      Get.to(
                        () => const DashboardScreen(),
                      );
                    });
                  }
                  controller.isLoading(false);
                },
              ),
            ],
          ),
        ),
      ),
    );
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
      setState(() {});
      adminPlayerID.value = documentSnapshot.get('id');
    });
  }

  String? adminName;

  getCurrentAdmin() {
    BackEndConfig.adminsCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot snapshot) {
      adminName = snapshot.get('name');
      setState(() {});
    });
  }
}
