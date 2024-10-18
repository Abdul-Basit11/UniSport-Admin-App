import 'package:cached_network_image/cached_network_image.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/controller/event_controller.dart';
import 'package:unisport_admin_app/utils/const/back_end_config.dart';
import 'package:unisport_admin_app/utils/const/colors.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';
import 'package:unisport_admin_app/view/home/all_teams_view/all_team_screen.dart';
import 'package:unisport_admin_app/view/home/applied_event_players/applied_event_player.dart';

import '../../../utils/const/sizes.dart';
import '../../../utils/widgets/event_approval_dialog.dart';

class GameDetailScreen extends StatelessWidget {
  final String gameId;
  final String gameName;

  const GameDetailScreen({super.key, required this.gameId, required this.gameName});

  @override
  Widget build(BuildContext context) {
    final eventController = Get.put(EventController());
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: Text(gameName.toString()),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            children: [
              20.sH,
              StreamBuilder(
                stream: BackEndConfig.eventsCollection
                    .where('event_game_id', isEqualTo: gameId.toString())
                    .where('admin_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Event Added yet for\n${gameName.toString()} !',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.titleSmall!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    Text(
                      'Some Thing Went Wrong 🚫',
                      style: Theme.of(context).textTheme.bodyLarge,
                    );
                  }
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimary,
                        strokeWidth: 5,
                      ),
                    );
                  }
                  return ListView.builder(
                    shrinkWrap: true,
                    primary: false,
                    itemCount: snapshot.data!.docs.length,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      return Banner(
                        message: data['isApproved'] == true ? "Approved" : 'Pending',
                        location: BannerLocation.topStart,
                        color: data['isApproved'] == true ? Colors.green : AppColors.kErrorColor,
                        child: Card(
                          child: ExpansionTile(
                            tilePadding: const EdgeInsets.all(8),
                            expandedAlignment: Alignment.centerLeft,
                            title: Text(
                              data['event_name'],
                              style: Theme.of(context).textTheme.bodyLarge,
                            ),
                            shape: RoundedRectangleBorder(
                                side: const BorderSide(color: AppColors.kPrimary),
                                borderRadius: BorderRadius.circular(12)),
                            subtitle: Text(
                              data['event_description'],
                              style: const TextStyle(
                                fontSize: 11,
                                fontWeight: FontWeight.w300,
                              ),
                              maxLines: 2,
                            ),
                            leading: ClipRRect(
                              borderRadius: BorderRadius.circular(10),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 90,
                                height: 100,
                                imageUrl: data['event_image'].toString(),
                                placeholder: (context, url) => const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kPrimary, // Loader color
                                  ),
                                ),
                                errorWidget: (context, url, error) => const Icon(Icons.error),
                              ),
                            ),
                            children: [
                              Padding(
                                padding: const EdgeInsets.symmetric(vertical: 5),
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    const Divider(),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                                      children: [
                                        Obx(
                                          () => CupertinoButton(
                                            onPressed: eventController.isApproved.value
                                                ? () {
                                                    BHelperFunction.navigate(
                                                      context,
                                                      AllTeamScreen(
                                                        eventName: data['event_name'],
                                                        eventGameId: data['event_game_id'],
                                                        eventGameName: data['event_game_name'],
                                                        eventId: data.id.toString(),
                                                      ),
                                                    );
                                                  }
                                                : () {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return EventApprovalAlertDialog();
                                                      },
                                                    );
                                                  },
                                            padding: EdgeInsets.zero,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text('Teams'),
                                                5.sH,
                                                const Icon(
                                                  Iconsax.people4,
                                                  size: 18,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                        Obx(
                                          () => CupertinoButton(
                                            onPressed: eventController.isApproved.value
                                                ? () {
                                                    BHelperFunction.navigate(
                                                      context,
                                                      AppliedEventPlayersScreen(
                                                        eventName: data['event_name'],
                                                        eventId: data.id.toString(),
                                                      ),
                                                    );
                                                  }
                                                : () {
                                                    showDialog(
                                                      barrierDismissible: false,
                                                      context: context,
                                                      builder: (context) {
                                                        return EventApprovalAlertDialog();
                                                      },
                                                    );
                                                  },
                                            padding: EdgeInsets.zero,
                                            child: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              children: [
                                                const Text('Players'),
                                                5.sH,
                                                const Icon(
                                                  Icons.man_2_rounded,
                                                  size: 18,
                                                )
                                              ],
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  ],
                                ),
                              ),
                              6.sH,
                            ],
                          ),
                        ),
                      );
                    },
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
