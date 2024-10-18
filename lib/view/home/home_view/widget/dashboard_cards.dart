import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';

import '../../../../utils/const/colors.dart';

class DashboardCards extends StatelessWidget {
  final String title, subtitle;
  const DashboardCards({super.key, required this.title, required this.subtitle});

  @override
  Widget build(BuildContext context) {
    final dark=BHelperFunction.isDarkMode(context);
    return Expanded(
      child: Container(
        height: 100,
        decoration: BoxDecoration(
          color: AppColors.kSecondary,
          borderRadius: BorderRadius.circular(12),
        ),
        child: Stack(
          clipBehavior: Clip.antiAliasWithSaveLayer,
          children: [
            const Positioned(
              left: -10,
              top: -10,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.kPrimary,
              ),
            ),
            Positioned(
              left: -10,
              top: -10,
              child: CircleAvatar(
                radius: 25,
                backgroundColor: AppColors.kwhite.withOpacity(0.5),
              ),
            ),
            const Positioned(
              right: -10,
              bottom: -10,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.kPrimary,
              ),
            ),
            Positioned(
              right: -10,
              bottom: -10,
              child: CircleAvatar(
                radius: 30,
                backgroundColor: AppColors.kwhite.withOpacity(0.5),
              ),
            ),
            Center(
              child: Row(
                crossAxisAlignment: CrossAxisAlignment.center,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Text(
                    title,
                    style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                      color: dark?AppColors.kwhite:AppColors.kwhite
                    ),
                  ),
                  Text(
                    subtitle,
                    style: Theme.of(context).textTheme.titleLarge!.copyWith(
                        color: dark?AppColors.kwhite:AppColors.kwhite,fontSize:20
                    ),
                  ),
                ],
              ),
            )
          ],
        ),
      ),
    );
  }
}
