import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';


import '../const/colors.dart';


class CustomScreenTitle extends StatelessWidget {
   CustomScreenTitle({super.key, required this.title, });
  final String title;

  @override
  Widget build(BuildContext context) {
    return  Row(
      children: [
        Container(
          height: 30,
          width: 4,
          decoration: BoxDecoration(color: AppColors.kPrimary, borderRadius: BorderRadius.circular(12)),
        ),
        10.sW,
        Text(
          title,
          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold,

          ),
        ),

      ],
    );
  }
}
