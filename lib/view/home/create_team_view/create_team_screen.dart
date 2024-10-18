import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unisport_admin_app/utils/const/back_end_config.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/loaders/loaders.dart';
import 'package:unisport_admin_app/utils/widgets/custom_button.dart';
import 'package:unisport_admin_app/utils/widgets/custom_loaders.dart';

import '../../../services/image_upload.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/image_picker_widget.dart';

class CreateTeamScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String eventGameName;
  final String eventGameID;

  const CreateTeamScreen({super.key, required this.eventId, required this.eventName, required this.eventGameName, required this.eventGameID});

  @override
  State<CreateTeamScreen> createState() => _CreateTeamScreenState();
}

class _CreateTeamScreenState extends State<CreateTeamScreen> {
  TextEditingController teamName = TextEditingController();
  TextEditingController maximumPlayer = TextEditingController();

  @override
  Widget build(BuildContext context) {
    return CustomLoader(
      isLoading: isLoading,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: Text('Create Team'),
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
                            decoration:
                                BoxDecoration(color: AppColors.kPrimary, borderRadius: BorderRadius.circular(12)),
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
                  controller: teamName,
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Team Name is required';
                    }
                  },
                  hintText: 'Team Name',
                  prefixIcon: Iconsax.people4,
                  isPrefixIcon: true,
                ),
                CustomTextField(
                  controller: maximumPlayer,
                  validator: (v) {
                    if (v.isEmpty) {
                      return 'Maximum Player is required';
                    }
                  },
                  hintText: 'Maximum Player',
                  prefixIcon: Icons.man,
                  textInputType: TextInputType.number,
                  isPrefixIcon: true,
                ),
                40.sH,
                CustomButton(
                  title: 'Create Team',
                  onPressed: () {
                    if (file == null) {
                      return Loaders.warningSnackBar(title: 'Warning', messagse: 'Please Select the logo fot team !');
                    }
                    if (teamName.text.isEmpty) {
                      return Loaders.warningSnackBar(title: 'Warning', messagse: 'Enter team Name');
                    }
                    if (maximumPlayer.text.isEmpty) {
                      return Loaders.warningSnackBar(title: 'Warning', messagse: 'Enter Maximum Player');
                    } else {
                      return createTeam();
                    }
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
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

  createTeam() async {
    makeLoadingTrue();
    String? imageURL;
    if (file != null) {
      imageURL = await ImageUpload().uploadImage(context, file: file!, folderName: 'teamLogo');
    }
    String teamId = BackEndConfig.teamsCollection.doc().id;
    BackEndConfig.teamsCollection.doc(teamId).set({
      'team_id': teamId,
      'team_name': teamName.text.toString(),
      'event_id': widget.eventId,
      'event_name': widget.eventName,
      'event_game_name': widget.eventGameName,
      'event_game_id': widget.eventGameID,
      'team_logo': imageURL,
      'maximum_player': maximumPlayer.text.toString(),
      'players': [],
    }).then((value) {
      makeLoadingFalse();
      Get.back();
      Loaders.successSnackBar(title: 'Success', messagse: 'Team Created Successfully ');
    });
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
