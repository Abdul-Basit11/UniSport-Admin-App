import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/const/image_string.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';

import '../../../utils/const/colors.dart';

class PendingPlayer extends StatelessWidget {
  const PendingPlayer({super.key});

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          children: [
            20.sH,
            Card(
              elevation: 5,
              color: AppColors.kGrey,
              child: Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  children: [
                    DottedBorder(
                      borderType: BorderType.Circle,
                      dashPattern: const [8],
                      radius: const Radius.circular(12),
                      padding: const EdgeInsets.all(6),
                      strokeWidth: 2,
                      color: AppColors.kPrimary,
                      child: const CircleAvatar(
                        radius: 20,
                        backgroundImage: AssetImage(ImageString.playerImage),
                        backgroundColor: AppColors.kSecondary,
                      ),
                    ),
                    12.sW,
                    Expanded(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          Text(
                            'Player Name',
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Text(
                            'Department Name',
                            style: Theme.of(context).textTheme.labelMedium,
                            maxLines: 1,
                          ),
                        ],
                      ),
                    ),
                    Expanded(
                      child: TextButton(
                        style: TextButton.styleFrom(
                          padding: EdgeInsets.zero,
                        ),
                        onPressed: () {},
                        child: Text(
                          'Pending Player',
                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                fontWeight: FontWeight.bold,
                                color: AppColors.kErrorColor,
                              ),
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            )
          ],
        ),
      ),
    );
  }
}
