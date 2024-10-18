import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:get_storage/get_storage.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/controller/event_controller.dart';
import 'package:unisport_admin_app/view/home/home_view/home_screen.dart';

import '../../../utils/const/colors.dart';
import '../../../utils/helper/helper_function.dart';
import '../game_wise_events/game_wise_events.dart';
import '../game_wise_team/game_wise_team.dart';
import '../setting_view/setting_screen.dart';

class DashboardScreen extends StatefulWidget {
  const DashboardScreen({super.key});

  @override
  State<DashboardScreen> createState() => _DashboardScreenState();
}

class _DashboardScreenState extends State<DashboardScreen> {
  final List _screenList = [
    HomeScreen(),
    GamesTabScreen(),
    GameWiseEvents(),
    SettingScreen(),
  ];
  int currentIndex = 0;
  NavigationDestinationLabelBehavior labelBehavior = NavigationDestinationLabelBehavior.onlyShowSelected;

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(EventController());
    final dark = BHelperFunction.isDarkMode(context);
    return Obx(
      () => Scaffold(
        body: eventController.isAdminApproved.value && eventController.isAdminBlocked.value
            ? Center(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      'You are blocked do to some reason ',
                      style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                    ),
                  ],
                ),
              )
            : eventController.isAdminApproved.value == false && eventController.isAdminBlocked.value == false
                ? Center(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text(
                          'Wait for Approval from Super Admin ',
                          style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  )
                : _screenList[currentIndex],

        // eventController.isAdminApproved.value
        //     ? _screenList[currentIndex]
        //     : Center(
        //             child: Column(
        //               mainAxisAlignment: MainAxisAlignment.center,
        //               children: [
        //                 Text(
        //                   'Wait for Approval from Super Admin',
        //                   style: Theme.of(context).textTheme.bodyLarge!.copyWith(fontWeight: FontWeight.bold),
        //                 ),
        //               ],
        //             ),
        //           ),
        bottomNavigationBar: NavigationBar(
          // height: 70,
          backgroundColor: dark ? AppColors.kSecondary : AppColors.kGrey,
          indicatorShape: BeveledRectangleBorder(side: BorderSide(color: AppColors.kwhite, width: 0.5)),
          elevation: 5,
          labelBehavior: labelBehavior,
          animationDuration: Duration(milliseconds: 700),
          selectedIndex: currentIndex,
          indicatorColor: dark ? AppColors.kPrimary : AppColors.kSecondary,
          onDestinationSelected: (index) {
            eventController.isAdminApproved.value
                ? setState(() {
                    currentIndex = index;
                  })
                : null;
          },
          destinations: [
            NavigationDestination(
              icon: Icon(Icons.dashboard_outlined),
              label: 'Home',
              selectedIcon: Icon(
                Icons.dashboard_rounded,
                color: dark ? AppColors.kwhite : AppColors.kwhite,
              ),
            ),
            NavigationDestination(
              icon: Icon(Iconsax.people4),
              label: 'Teams',
              selectedIcon: Icon(
                Iconsax.people5,
                color: dark ? AppColors.kwhite : AppColors.kwhite,
              ),
            ),
            NavigationDestination(
              icon: Icon(Iconsax.menu),
              label: 'Evenets',
              selectedIcon: Icon(
                Iconsax.menu5,
                color: dark ? AppColors.kwhite : AppColors.kwhite,
              ),
            ),
            NavigationDestination(
              icon: Icon(CupertinoIcons.settings),
              label: 'Setting',
              selectedIcon: Icon(
                CupertinoIcons.settings_solid,
                color: dark ? AppColors.kwhite : AppColors.kwhite,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
