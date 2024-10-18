import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';

import '../../../utils/const/colors.dart';
import '../../../utils/helper/helper_function.dart';
import '../../../utils/widgets/custom_button.dart';

class EventDetailScreen extends StatelessWidget {
  dynamic data;

  EventDetailScreen({super.key, this.data});

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunction.isDarkMode(context);
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(
          data['event_game_name'],
          style: Theme.of(context).textTheme.titleSmall,
        ),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            children: [
              20.sH,
              Banner(
                location: BannerLocation.topStart,
                color: data['isApproved'] == true ?AppColors.kGreenColor:AppColors.kErrorColor,
                message: data['isApproved'] == true ?'Approved':'Pending',
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(10),
                  child: CachedNetworkImage(
                    fit: BoxFit.cover,
                    height: BHelperFunction.screenHeight() * 0.4,
                    width: double.infinity,
                    imageUrl: data['event_image'].toString(),
                    placeholder: (context, url) => const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimary, // Loader color
                      ),
                    ),
                    errorWidget: (context, url, error) => const Icon(Icons.error),
                  ),
                ),
              ),
              // Container(
              //   clipBehavior: Clip.antiAliasWithSaveLayer,
              //   height: BHelperFunction.screenHeight() * 0.4,
              //   width: double.infinity,
              //   decoration: BoxDecoration(borderRadius: BorderRadius.circular(AppSizes.md)),
              //   child: ImageBuilderWidget(
              //     imageRadius: 12,
              //     width: double.infinity,
              //     progressIndicatorColor: AppColors.kPrimary,
              //     image: data['event_image'].toString(),
              //   ),
              // ),
              10.sH,
              Container(
                padding: const EdgeInsets.all(12),
                width: double.infinity,
                decoration:
                    BoxDecoration(color: AppColors.kSecondary, borderRadius: BorderRadius.circular(AppSizes.md)),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Row(
                      children: [
                        Container(
                          height: 30,
                          width: 4,
                          decoration: BoxDecoration(color: AppColors.kPrimary, borderRadius: BorderRadius.circular(12)),
                        ),
                        10.sW,
                        Text.rich(
                          TextSpan(
                            children: [
                              TextSpan(
                                  text: "${data['event_game_name']}\t/\t",
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: AppColors.kwhite, fontWeight: FontWeight.bold)),
                              TextSpan(
                                  text: data['event_name'],
                                  style: Theme.of(context)
                                      .textTheme
                                      .labelMedium!
                                      .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold)),
                            ],
                          ),
                        ),
                      ],
                    ),
                    15.sH,
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Event Date',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: dark ? Colors.white : Colors.white),
                        ),
                        Text(
                          data['event_date'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: dark ? Colors.white : Colors.white),
                        ),
                      ],
                    ),
                    const Divider(),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          'Event Time',
                          style: Theme.of(context)
                              .textTheme
                              .labelMedium!
                              .copyWith(color: dark ? Colors.white : Colors.white),
                        ),
                        Text(
                          data['event_time'],
                          style: Theme.of(context)
                              .textTheme
                              .bodyLarge!
                              .copyWith(color: dark ? Colors.white : Colors.white),
                        ),
                      ],
                    ),
                    15.sH,
                    Text(
                      'Description',
                      style: Theme.of(context)
                          .textTheme
                          .bodyLarge!
                          .copyWith(color: dark ? Colors.white : Colors.white, fontWeight: FontWeight.bold),
                    ),
                    8.sH,
                    Text(
                      data['event_description'],
                      style:
                          Theme.of(context).textTheme.labelMedium!.copyWith(color: dark ? Colors.white : Colors.white),
                    ),
                    25.sH,
                    CustomButton(
                      title: 'View Teams',
                      onPressed:  () {} ,
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
