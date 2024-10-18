import 'dart:convert';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:unisport_admin_app/utils/const/back_end_config.dart';
import 'package:unisport_admin_app/utils/const/image_string.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';
import 'package:http/http.dart' as http;
import '../../../utils/const/colors.dart';

class PlayerStatusScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final bool isApproved;

  const PlayerStatusScreen({super.key, required this.eventId, required this.isApproved, required this.eventName});

  @override
  State<PlayerStatusScreen> createState() => _PlayerStatusScreenState();
}

class _PlayerStatusScreenState extends State<PlayerStatusScreen> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
      child: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            20.sH,
            Text(
              'Player\t\t',
              style: Theme.of(context).textTheme.titleLarge,
            ),
            15.sH,
            StreamBuilder(
              stream: BackEndConfig.applyGamesCollection
                  .where('event_id', isEqualTo: widget.eventId)
                  .where('isApproved', isEqualTo: widget.isApproved)
                  .snapshots(),
              builder: (context, snapshot) {
                if (snapshot.connectionState == ConnectionState.waiting) {
                  return const Center(
                      child: CircularProgressIndicator(
                    color: AppColors.kPrimary,
                  ));
                } else if (snapshot.hasError) {
                  return const Text('SomeThing Went Wrong:');
                } else if (snapshot.data!.docs.isEmpty) {
                  return const Center(
                    child: Text("No Player is available !"),
                  );
                }
                return ListView.builder(
                  shrinkWrap: true,
                  itemCount: snapshot.data!.docs.length,
                  itemBuilder: (context, index) {
                    var data = snapshot.data!.docs[index];
                    return CupertinoButton(
                      padding: EdgeInsets.zero,
                      onPressed: () {
                        showDialog(
                          barrierDismissible: false,
                          context: context,
                          builder: (context) {
                            return Dialog(
                              child: Card(
                                child: Padding(
                                  padding: const EdgeInsets.all(12.0),
                                  child: Column(
                                    crossAxisAlignment: CrossAxisAlignment.start,
                                    mainAxisSize: MainAxisSize.min,
                                    children: [
                                      Align(
                                          alignment: Alignment.topRight,
                                          child: IconButton(
                                            padding: EdgeInsets.zero,
                                            onPressed: () {
                                              Get.back();
                                            },
                                            icon: const Icon(Icons.close),
                                          )),
                                      const Center(child: Text('User Detail')),
                                      20.sH,
                                      const Text(
                                        'Department',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      5.sH,
                                      Text(
                                        data['player_department_name'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                      10.sH,
                                      const Text(
                                        'Description',
                                        style: TextStyle(fontWeight: FontWeight.bold),
                                      ),
                                      5.sH,
                                      Text(
                                        data['player_description'],
                                        maxLines: 3,
                                        overflow: TextOverflow.ellipsis,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        );
                      },
                      child: Card(
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
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(50),
                                  child: data['player_image'] == ''
                                      ? Image.asset(
                                          ImageString.placeholder,
                                          fit: BoxFit.cover,
                                          height: 35,
                                          width: 35,
                                        )
                                      : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          height: 35,
                                          width: 35,
                                          imageUrl: data['player_image'].toString(),
                                          placeholder: (context, url) => const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.kPrimary,
                                              // Loader color
                                            ),
                                          ),
                                          errorWidget: (context, url, error) => const Icon(Icons.downloading),
                                        ),
                                ),
                              ),
                              12.sW,
                              Expanded(
                                child: Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      data['apply_player_name'].toString(),
                                      style:
                                          Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                  ],
                                ),
                              ),
                              data['isApproved'] == true
                                  ? Text(
                                      'Approved',
                                      style: Theme.of(context).textTheme.bodySmall!.copyWith(
                                            color: AppColors.kGreenColor,
                                            fontWeight: FontWeight.bold,
                                            fontSize: 12,
                                          ),
                                    )
                                  : PopupMenuButton(
                                      color: BHelperFunction.isDarkMode(context)
                                          ? AppColors.kLightGrey
                                          : AppColors.kSecondary,
                                      itemBuilder: (context) => [
                                        PopupMenuItem(
                                          onTap: () {
                                            BackEndConfig.applyGamesCollection.doc(data.id).set(
                                              {
                                                'isApproved': true,
                                              },
                                              SetOptions(merge: true),
                                            ).then((value) async {
                                              String playerId = await getPlayerId(data['applier_id'].toString());
                                              sendNotification(
                                                  'Congratulation🎉\nyou have been approved in the ${widget.eventName} event',
                                                  playerId);
                                            });
                                          },
                                          child: Text(
                                            data['isApproved'] == true ? 'Pending' : 'Approved',
                                            style: TextStyle(
                                                fontWeight: FontWeight.bold,
                                                color: data['isApproved'] == true
                                                    ? AppColors.kGreenColor
                                                    : AppColors.kErrorColor),
                                          ),
                                        ),
                                      ],
                                    ),
                            ],
                          ),
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
    );
  }

  Future<String> getPlayerId(String adminId) async {
    DocumentSnapshot documentSnapshot = await FirebaseFirestore.instance.collection('tokens').doc(adminId).get();
    setState(() {});
    return documentSnapshot.get('id');
  }

  sendNotification(String content, String playerID) async {
    var headers = {
      'Authorization': 'Bearer MzFmZTM5NWEtM2NjYS00NzA3LTg0OTctOGJmZjg2YjdiYzRl',
      'Content-Type': 'application/json',
    };
    var request = http.Request('POST', Uri.parse('https://onesignal.com/api/v1/notifications'));
    request.body = json.encode({
      "app_id": "1108f2cd-f8b5-4d2f-9fcf-e42b4b9c8dd0",
      "include_player_ids": [playerID],
      // "include_player_ids": ["ade0858e-5c24-4115-950c-464526346bc4"],
      "contents": {"en": content}
    });
    request.headers.addAll(headers);

    http.StreamedResponse response = await request.send();

    if (response.statusCode == 200) {
      print(await response.stream.bytesToString());
    } else {
      print(response.reasonPhrase);
    }
  }
}
