import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unisport_admin_app/utils/widgets/custom_button.dart';

import '../../../utils/const/colors.dart';
import '../../../utils/const/sizes.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/image_picker_widget.dart';

class AddGameScreen extends StatefulWidget {
  @override
  State<AddGameScreen> createState() => _AddGameScreenState();
}

class _AddGameScreenState extends State<AddGameScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text('Add Games'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            children: [
              20.sH,
              file == null
                  ? Center(
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: [8],
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        color: AppColors.kPrimary,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(color: AppColors.kPrimary, borderRadius: BorderRadius.circular(12)),
                          child: Center(
                            child: IconButton(
                              onPressed: () {
                                showModalBottomSheet(
                                  backgroundColor: Colors.transparent,
                                  elevation: 0,
                                  isDismissible: false,
                                  context: context,
                                  builder: (context) {
                                    return ImagePickerWidget(
                                      camera: () {
                                        Navigator.pop(context);
                                        _pickImage(ImageSource.camera);
                                      },
                                      gallery: () {
                                        Navigator.pop(context);

                                        _pickImage(ImageSource.gallery);
                                      },
                                    );
                                  },
                                );
                              },
                              icon: const Icon(Iconsax.camera),
                            ),
                          ),
                        ),
                      ),
                    )
                  : Center(
                      child: InkWell(
                        onTap: () {
                          showModalBottomSheet(
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            isDismissible: false,
                            context: context,
                            builder: (context) {
                              return ImagePickerWidget(
                                camera: () {
                                  Navigator.pop(context);
                                  _pickImage(ImageSource.camera);
                                },
                                gallery: () {
                                  Navigator.pop(context);

                                  _pickImage(ImageSource.gallery);
                                },
                              );
                            },
                          );
                        },
                        child: DottedBorder(
                          borderType: BorderType.RRect,
                          dashPattern: [8],
                          radius: const Radius.circular(12),
                          padding: const EdgeInsets.all(6),
                          color: AppColors.kPrimary,
                          child: Container(
                            height: 120,
                            width: 120,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(12),
                              child: Image.file(
                                file!,
                                fit: BoxFit.cover,
                              ),
                            ),
                          ),
                        ),
                      ),
                    ),
              20.sH,
              CustomTextField(
                hintText: 'Game Name',
                prefixIcon: Iconsax.gameboy5,
                isPrefixIcon: true,
              ),
              40.sH,
              CustomButton(
                title: 'Add',
                onPressed: () {},
              ),
            ],
          ),
        ),
      ),
    );
  }

  File? file;

  ImagePicker imagePicker = ImagePicker();

  Future<void> _pickImage(ImageSource source) async {
    final pickedFile = await imagePicker.pickImage(source: source);

    setState(() {
      file = File(pickedFile!.path);
    });
  }
}
