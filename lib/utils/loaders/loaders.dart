import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'package:iconsax/iconsax.dart';

import '../const/colors.dart';

class Loaders {
  static hideSnackBar() => ScaffoldMessenger.of(Get.context!).hideCurrentSnackBar();

  static customToast({required message}) {
    ScaffoldMessenger.of(Get.context!).showSnackBar(

      SnackBar(

        elevation: 0,
        duration: Duration(seconds: 3),
        backgroundColor: Colors.transparent,
        content: Container(
            padding: EdgeInsets.all(12),
            margin: EdgeInsets.symmetric(horizontal: 30),
            decoration: BoxDecoration(
              borderRadius: BorderRadius.circular(30),
              color: AppColors.kPrimary,
            ),
            child: Text(message, style: Theme.of(Get.context!).textTheme.labelLarge)),
      ),
    );
  }

  static successSnackBar({required title, messagse = '', duration = 3}) {
    Get.snackbar(
      title,
      messagse,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.kblack,
      backgroundColor: AppColors.kGreenColor,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: duration),
      margin: EdgeInsets.all(10),
      icon: Icon(Iconsax.check, color: AppColors.kwhite),
    );
  }

  static warningSnackBar({required title, messagse = ''}) {
    Get.snackbar(
      title,
      messagse,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.kwhite,
      backgroundColor: Colors.orange,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      icon: Icon(Iconsax.warning_2, color: AppColors.kwhite),
    );
  }

  static errorSnackBar({required title, messagse = ''}) {
    Get.snackbar(
      title,
      messagse,
      isDismissible: true,
      shouldIconPulse: true,
      colorText: AppColors.kwhite,
      backgroundColor: Colors.red.shade600,
      snackPosition: SnackPosition.BOTTOM,
      duration: Duration(seconds: 3),
      margin: EdgeInsets.all(8),
      icon: Icon(Iconsax.warning_2, color: AppColors.kwhite),
    );
  }
}
