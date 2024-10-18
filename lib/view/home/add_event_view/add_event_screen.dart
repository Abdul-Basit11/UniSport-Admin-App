import 'dart:io';

import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:image_picker/image_picker.dart';
import 'package:unisport_admin_app/controller/event_controller.dart';
import 'package:unisport_admin_app/utils/const/colors.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';
import 'package:unisport_admin_app/utils/loaders/loaders.dart';
import 'package:unisport_admin_app/utils/widgets/custom_button.dart';
import 'package:unisport_admin_app/utils/widgets/custom_loaders.dart';

import '../../../utils/widgets/custom_textfield.dart';
import '../../../utils/widgets/image_picker_widget.dart';

class ADDEventScreen extends StatefulWidget {
  @override
  State<ADDEventScreen> createState() => _ADDEventScreenState();
}

class _ADDEventScreenState extends State<ADDEventScreen> {
  TextEditingController _dateController = TextEditingController();
  TextEditingController _timeController = TextEditingController();

  TimeOfDay _selectedTime = TimeOfDay.now();
  DateTime _selectedDate = DateTime.now();

  Future<void> _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: _selectedDate,
      firstDate: DateTime(2000),
      lastDate: DateTime(2101),
    );

    if (picked != null && picked != _selectedDate) {
      setState(() {
        _selectedDate = picked;
        _dateController.text = '${_selectedDate.toLocal()}'.split(' ')[0];
      });
    }
  }

  Future<void> _selectTime(BuildContext context) async {
    final TimeOfDay? picked = await showTimePicker(
      context: context,
      initialTime: _selectedTime,
    );

    if (picked != null && picked != _selectedTime) {
      setState(() {
        _selectedTime = picked;
        _timeController.text = _selectedTime.format(context);
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(EventController());
    return Obx(
      () => CustomLoader(
        isLoading: eventController.isLoading.value,
        child: Scaffold(
          appBar: AppBar(
            centerTitle: true,
            title: const Text('Add Event'),
          ),
          body: SingleChildScrollView(
            child: Padding(
              padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
              child: Form(
                key: eventController.eventKey,
                child: Column(
                  children: [
                    20.sH,
                    Center(
                      child: DottedBorder(
                        borderType: BorderType.RRect,
                        dashPattern: [8],
                        radius: const Radius.circular(12),
                        padding: const EdgeInsets.all(6),
                        color: AppColors.kPrimary,
                        child: Container(
                          height: 120,
                          width: 120,
                          decoration: BoxDecoration(
                            color: AppColors.kPrimary,
                            borderRadius: BorderRadius.circular(12),
                          ),
                          child: eventController.imagePath.value == ''
                              ? Center(
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
                                              eventController.pickImage(imageSource: ImageSource.camera);
                                            },
                                            gallery: () {
                                              Navigator.pop(context);

                                              eventController.pickImage(imageSource: ImageSource.gallery);
                                            },
                                          );
                                        },
                                      );
                                    },
                                    icon: const Icon(Iconsax.camera),
                                  ),
                                )
                              : ClipRRect(
                                  borderRadius: BorderRadius.circular(12),
                                  child: Image.file(
                                    File(
                                      eventController.imagePath.value,
                                    ),
                                    fit: BoxFit.cover,
                                  ),
                                ),
                        ),
                      ),
                    ),
                    20.sH,
                    CustomTextField(
                      controller: eventController.eventNameController,
                      validator: (va) {
                        if (va.isEmpty) {
                          return 'Enter the event title';
                        }
                      },
                      hintText: 'Event Name',
                      prefixIcon: Icons.event_note_rounded,
                      isPrefixIcon: true,
                    ),
                    CustomTextField(
                      controller: eventController.eventDescriptionController,
                      validator: (va) {
                        if (va.isEmpty) {
                          return 'Enter the event Description';
                        }
                      },
                      hintText: 'Event Description',
                      prefixIcon: Iconsax.note,
                      isPrefixIcon: true,
                      maxline: null,
                    ),
                    CustomTextField(
                      controller: eventController.participantsController,
                      validator: (va) {
                        if (va.isEmpty) {
                          return 'Enter the Participant No';
                        }
                      },
                      hintText: 'Event Participants',
                      prefixIcon: Icons.numbers,
                      isPrefixIcon: true,
                      textInputType: TextInputType.number,
                    ),
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
                            Text(eventController.gameName.value == "" ? "Game Name" : eventController.gameName.value,
                                style: context.textTheme.labelLarge),
                            const Spacer(),
                            IconButton(
                              onPressed: () {
                                eventController.isTapped.value = !eventController.isTapped.value;
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
                      () => eventController.isTapped.value
                          ? Container(
                              height: 120,
                              width: MediaQuery.of(context).size.width,
                              child: Card(
                                elevation: 2,
                                color: Colors.white,
                                child: ListView.builder(
                                    physics: const BouncingScrollPhysics(),
                                    itemCount: eventController.allGamesList.length,
                                    itemBuilder: (context, i) {
                                      return InkWell(
                                          onTap: () {
                                            eventController.gameName.value =
                                                eventController.allGamesList[i]["game_name"];
                                            eventController.gameId.value = eventController.allGamesList[i]["game_id"];
                                            eventController.isTapped.value = !eventController.isTapped.value;
                                          },
                                          child: Padding(
                                            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 4),
                                            child: Obx(
                                              () => Text(
                                                eventController.allGamesList[i]["game_name"],
                                                style: const TextStyle(
                                                    fontSize: 14, color: Colors.black, fontWeight: FontWeight.w500),
                                              ),
                                            ),
                                          ));
                                    }),
                              ),
                            )
                          : const SizedBox(),
                    ),
                    15.sH,
                    Row(
                      children: [
                        Expanded(
                          child: CustomTextField(
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Please Select Date!';
                              }
                            },
                            hintText: 'Select Date',
                            controller: _dateController,
                            onTapped: () => _selectDate(context),
                            readOnly: true,
                          ),
                        ),
                        10.sW,
                        Expanded(
                          child: CustomTextField(
                            validator: (v) {
                              if (v.isEmpty) {
                                return 'Please Select Time!';
                              }
                            },
                            hintText: 'Select Time',
                            controller: _timeController,
                            onTapped: () => _selectTime(context),
                            readOnly: true,
                          ),
                        ),
                      ],
                    ),
                    40.sH,
                    CustomButton(
                        title: 'Add',
                        onPressed: () async {
                          if (eventController.validateEvent(
                              _timeController.text.toString(), _dateController.text.toString())) {
                            eventController.isLoading(true);
                            await eventController.uploadProfileImage();
                            await eventController.addEvent(
                              adminName: eventController.adminName.value,
                              departmentName: eventController.departmentName.value.toString(),
                              eventDate: _dateController.text.toString(),
                              eventTime: _timeController.text.toString(),
                              gameId: eventController.gameId.value.toString(),
                              gameName: eventController.gameName.value.toString(),
                            );
                            eventController.isLoading(false);
                          }
                        }),
                  ],
                ),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
