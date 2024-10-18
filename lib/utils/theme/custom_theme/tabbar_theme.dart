import 'package:flutter/material.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';

import '../../const/colors.dart';
import '../../const/sizes.dart';

class AppTabbarTheme {
  static TabBarTheme lightTabbar(BuildContext context) {
    return TabBarTheme(
      unselectedLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color: AppColors.kGrey),
      labelColor: AppColors.kwhite,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
      indicator: BoxDecoration(
          color: AppColors.kPrimary,
          borderRadius: BorderRadius.circular(AppSizes.xl),
          boxShadow: [BoxShadow(color: AppColors.kblack.withOpacity(0.5), offset: Offset(4, 0), blurRadius: 10)]),
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }

  static TabBarTheme darkTabbar(BuildContext context) {
    return TabBarTheme(
      unselectedLabelStyle: Theme.of(context).textTheme.bodySmall!.copyWith(color:Theme.of(context).colorScheme.background),
      labelColor: Theme.of(context).colorScheme.background,
      labelPadding: const EdgeInsets.symmetric(horizontal: 20),
      indicator: BoxDecoration(
          color: AppColors.kPrimary,
          borderRadius: BorderRadius.circular(AppSizes.xl),
          boxShadow: [BoxShadow(color: AppColors.kblack.withOpacity(0.5), offset: Offset(4, 0), blurRadius: 10)]),
      dividerColor: Colors.transparent,
      indicatorSize: TabBarIndicatorSize.tab,
    );
  }
}
