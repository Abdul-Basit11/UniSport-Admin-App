import 'dart:io';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unisport_admin_app/controller/profile_controler.dart';
import 'package:unisport_admin_app/utils/widgets/custom_loaders.dart';
import 'package:unisport_admin_app/utils/widgets/image_builder_widget.dart';

import '../../../utils/const/colors.dart';
import '../../../utils/const/sizes.dart';
import '../../../utils/widgets/custom_button.dart';
import '../../../utils/widgets/custom_screen_title.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../authentication/signup_screen/widget/image_picker_widget.dart';

class EditProfileScreen extends StatelessWidget {
  var image;
  final String name;

  EditProfileScreen({super.key, required this.image, required this.name});

  @override
  Widget build(BuildContext context) {
    final profileController = Get.put(ProfileControler());
    profileController.nameController.text = name;
    return Obx(
      () => CustomLoader(
        isLoading: profileController.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: Text(
              'Edit Profile',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  10.sH,
                  CustomScreenTitle(title: 'Update Picture'),
                  40.sH,
                  InkWell(
                    onTap: () {
                      showModalBottomSheet(
                        backgroundColor: Colors.transparent,
                        elevation: 0,
                        isDismissible: false,
                        context: context,
                        builder: (context) {
                          return ImagePickerWidget(
                            cameraTapped: () {
                              Get.back();
                              profileController.pickImage(imageSource: ImageSource.camera);
                            },
                            galleryTapped: () {
                              Get.back();

                              profileController.pickImage(imageSource: ImageSource.gallery);
                            },
                          );
                        },
                      );
                    },
                    child: Center(
                      child: Container(
                        height: 100,
                        width: 100,
                        clipBehavior: Clip.antiAlias,
                        decoration: BoxDecoration(
                          shape: BoxShape.circle,
                          color: AppColors.kSecondary,
                          boxShadow: [
                            BoxShadow(
                              color: Colors.black.withOpacity(0.2),
                              blurRadius: 25,
                              offset: const Offset(2, 3),
                            ),
                          ],
                        ),
                        child: image == '' && profileController.imagePath.value.isEmpty
                            ? const Icon(
                                Iconsax.camera,
                                color: AppColors.kPrimary,
                                size: 25,
                              )
                            : image != '' && profileController.imagePath.value.isEmpty
                                ? ImageBuilderWidget(
                                    image: image.toString(),
                                  )
                                : Image.file(
                                    File(
                                      profileController.imagePath.value,
                                    ),
                                    width: 80,
                                    height: 100,
                                    fit: BoxFit.cover,
                                  ),
                      ),
                    ),
                  ),
                  25.sH,
                  CustomScreenTitle(title: 'Update Information'),
                  25.sH,
                  CustomTextField(
                      controller: profileController.nameController,
                      hintText: 'Name',
                      prefixIcon: Iconsax.user_edit,
                      isPrefixIcon: true),
                  30.sH,
                  CustomButton(
                    title: 'Update',
                    onPressed: () async {
                      profileController.isLoading(true);
                      if (profileController.imagePath.value.isNotEmpty) {
                        await profileController.uploadProfileImage();
                      } else {
                        profileController.imageLink.value = image.toString();
                      }
                      profileController.updateProfile(
                        name: profileController.nameController.text,
                        imgUrl: profileController.imageLink.value,
                      );
                      profileController.isLoading(false);
                    },
                  ),
                  20.sH,
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
