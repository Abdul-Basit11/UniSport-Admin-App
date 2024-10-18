import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_state.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/widgets/custom_divider.dart';
import 'package:unisport_admin_app/utils/widgets/custom_screen_title.dart';
import 'package:unisport_admin_app/view/home/edit_profile_screen/edit_profile_screen.dart';

import '../../../controller/theme_controller.dart';
import '../../../utils/const/back_end_config.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_string.dart';
import '../../../utils/helper/helper_function.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/image_builder_widget.dart';
import '../../authentication/login_screen/login_screen.dart';
import '../change_password_view/change_password_screen.dart';
import 'widget/setting_tile.dart';

class SettingScreen extends StatefulWidget {
  const SettingScreen({super.key});

  @override
  State<SettingScreen> createState() => _SettingScreenState();
}

class _SettingScreenState extends State<SettingScreen> {
  @override
  Widget build(BuildContext context) {
    final ThemeController _themeController = Get.put(ThemeController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          'Setting',
          style: Theme.of(context).textTheme.titleMedium,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            children: [
              10.sH,
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(12),
                decoration: BoxDecoration(
                  color: AppColors.kGrey,
                  borderRadius: BorderRadius.circular(AppSizes.md),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Admin Profile',
                          style: Theme.of(context).textTheme.titleSmall!.copyWith(
                              fontWeight: FontWeight.bold,
                              color: BHelperFunction.isDarkMode(context) ? Colors.white : Colors.white),
                        ),
                        image == ''
                            ? ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: Image.asset(
                                  ImageString.placeholder,
                                  fit: BoxFit.cover,
                                  width: 40,
                                  height: 40,
                                ),
                              )
                            : ClipRRect(
                                borderRadius: BorderRadius.circular(60),
                                child: ImageBuilderWidget(
                                  width: 40,
                                  height: 40,
                                  image: image.toString(),
                                ),
                              ),
                      ],
                    ),
                    Text.rich(TextSpan(children: [
                      TextSpan(text: 'HI,\t\t', style: Theme.of(context).textTheme.labelLarge),
                      TextSpan(text: name ?? 'Name', style: Theme.of(context).textTheme.titleMedium),
                    ])),
                    Text(email ?? 'admin@gmail.com', style: Theme.of(context).textTheme.labelMedium),
                    10.sH,
                    Row(
                      children: [
                        Expanded(
                          child: CustomButton(
                            title: 'Edit',
                            onPressed: () {
                              Get.to(
                                () => EditProfileScreen(
                                  image: image.toString(),
                                  name: name.toString(),
                                ),
                              );
                            },
                            height: 45,
                          ),
                        ),
                        const Expanded(flex: 2, child: SizedBox()),
                      ],
                    )
                    // OutlinedButton(onPressed: () {}, child: Text('View'))
                  ],
                ),
              ),
              20.sH,
              const CustomDivider(),
              15.sH,
              SettingTile(
                title: _themeController.theme == ThemeMode.dark ? 'Dark Theme' : 'Light Theme',
                widget: GetBuilder<ThemeController>(
                  builder: (controller) => Switch(
                    value: controller.theme == ThemeMode.dark,
                    onChanged: (value) {
                      controller.switchTheme();
                    },
                  ),
                ),
              ),
              10.sH,
              SettingTile(
                title: 'Change Password',
                widget: Icon(
                  Iconsax.arrow_circle_right,
                  color: AppColors.kPrimary,
                ),
                onTaped: () {
                  Get.to(() => ChangePasswordScreen());
                },
              ),
              15.sH,
              CustomScreenTitle(title: 'Notification'),
              20.sH,
              SettingTile(
                title: 'Notification',
                widget: Switch(value: false, onChanged: (v) {}),
              ),
              SettingTile(
                title: 'Logout',
                widget: const Icon(
                  Iconsax.logout,
                  color: AppColors.kPrimary,
                ),
                onTaped: () {
                  showDialog(
                    context: context,
                    builder: (context) {
                      return Dialog(
                        backgroundColor: Colors.transparent,
                        child: Card(
                          color: AppColors.kSecondary,
                          elevation: 10,
                          shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(AppSizes.md)),
                          child: Padding(
                            padding: const EdgeInsets.all(AppSizes.sm),
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              children: [
                                10.sH,
                                Text(
                                  'Logout',
                                  style: Theme.of(context).textTheme.titleMedium!.copyWith(
                                        color: AppColors.kwhite,
                                      ),
                                ),
                                8.sH,
                                Text(
                                  'Oh,No you are leaving',
                                  style: Theme.of(context).textTheme.bodyLarge!.copyWith(color: AppColors.kwhite),
                                ),
                                25.sH,
                                CustomButton(
                                  title: 'Logout',
                                  onPressed: () {
                                    FirebaseAuth.instance.signOut().then((value) {
                                      return Get.offAll(() => LoginScreen());
                                    });
                                  },
                                  height: 42,
                                ),
                                8.sH,
                                SizedBox(
                                    height: 42,
                                    width: double.infinity,
                                    child: OutlinedButton(
                                        onPressed: () {
                                          Navigator.pop(context);
                                        },
                                        child: Text('No',
                                            style: Theme.of(context)
                                                .textTheme
                                                .bodySmall!
                                                .copyWith(fontWeight: FontWeight.bold, color: Colors.white)))),
                                10.sH,
                              ],
                            ),
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
              50.sH,
              Center(
                child: Text(
                  'App Version 1.0.0+1',
                  style: Theme.of(context).textTheme.bodySmall!.copyWith(shadows: [
                    Shadow(color: Colors.black.withOpacity(0.3), offset: const Offset(4, 0), blurRadius: 10),
                  ], color: AppColors.kPrimary),
                ),
              ),
              10.sH,
            ],
          ),
        ),
      ),
    );
  }

  String? email;

  String? name;
  String? image;

  getCurrentUser() {
    BackEndConfig.adminsCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      setState(() {});
      name = documentSnapshot.get('name');
      email = documentSnapshot.get('email');
      image = documentSnapshot.get('image');
    });
  }

  @override
  void initState() {
    super.initState();
    getCurrentUser();
  }
}
