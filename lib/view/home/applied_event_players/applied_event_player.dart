import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';
import 'package:unisport_admin_app/view/home/all_teams_view/all_team_screen.dart';

import '../../../utils/const/colors.dart';
import '../../../utils/const/sizes.dart';
import 'approved_player.dart';
import 'pending_players.dart';

class AppliedEventPlayersScreen extends StatefulWidget {
  final String eventId;
  final String eventName;

   AppliedEventPlayersScreen({super.key,required this.eventId, required this.eventName});
  @override
  State<AppliedEventPlayersScreen> createState() => _AppliedEventPlayersScreenState();
}

class _AppliedEventPlayersScreenState extends State<AppliedEventPlayersScreen> with SingleTickerProviderStateMixin {
  int currentIndex = 0;
  late TabController _tabController;

  @override
  void initState() {
    super.initState();
    _tabController = TabController(vsync: this, length: 2);
  }

  @override
  void dispose() {
    _tabController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      initialIndex: currentIndex,
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          centerTitle: true,
          title: const Text('Applied Events Player'),
        ),
        body: Column(
          children: [
            20.sH,
            Container(
              height: 68,
              margin: const EdgeInsets.symmetric(horizontal: 20),
              decoration: BoxDecoration(
                color: AppColors.kSecondary,
                borderRadius: BorderRadius.circular(AppSizes.xl),
              ),
              child: TabBar(
                  onTap: (v) {
                    setState(() {
                      currentIndex = v;
                    });
                  },
                  controller: _tabController,
                  physics: const NeverScrollableScrollPhysics(),
                  indicatorPadding: const EdgeInsets.all(10),
                  indicatorSize: TabBarIndicatorSize.tab,
                  tabs: [
                    Tab(
                      child: Text(
                        'Approved Player',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),
                    Tab(
                      child: Text(
                        'Pending Players',
                        style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w500),
                      ),
                    ),

                  ]),
            ),
            Expanded(
                child: TabBarView(
              controller: _tabController,
              physics: NeverScrollableScrollPhysics(),
              children: [
                PlayerStatusScreen(eventId: widget.eventId, isApproved: true,eventName: widget.eventName.toString(),),
                PlayerStatusScreen(eventId: widget.eventId, isApproved: false,eventName: widget.eventName.toString(),),


              ],
            ))
          ],
        ),
        // floatingActionButton: _tabController.index == 1
        //     ? FloatingActionButton.extended(
        //         onPressed: () {
        //           BHelperFunction.navigate(context, AllTeamScreen());
        //         },
        //         label: Text('Create Team'),
        //       )
        //     : SizedBox(),
      ),
    );
  }
}
