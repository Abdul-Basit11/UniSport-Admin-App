// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:unisport_admin_app/utils/const/sizes.dart';
// import 'package:unisport_admin_app/utils/helper/helper_function.dart';
// import 'package:unisport_admin_app/view/home/create_team_view/create_team_screen.dart';
// import 'package:unisport_admin_app/view/home/select_player_view/select_player_screen.dart';
//
// import '../../../utils/const/back_end_config.dart';
// import '../../../utils/const/colors.dart';
//
// class AllTeamScreen extends StatefulWidget {
//   final String eventId;
//   final String eventName;
//   final String eventGameName;
//   final String eventGameId;
//
//   const AllTeamScreen(
//       {super.key,
//       required this.eventId,
//       required this.eventName,
//       required this.eventGameName,
//       required this.eventGameId});
//
//   @override
//   State<AllTeamScreen> createState() => _AllTeamScreenState();
// }
//
// class _AllTeamScreenState extends State<AllTeamScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Team'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
//           child: Column(
//             children: [
//               20.sH,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'All Teams\t\t',
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         TextSpan(
//                           text: 'º 1',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       BHelperFunction.navigate(
//                         context,
//                         CreateTeamScreen(
//                           eventGameID: widget.eventGameId,
//                           eventGameName: widget.eventGameName,
//                           eventName: widget.eventName,
//                           eventId: widget.eventId,
//                         ),
//                       );
//                     },
//                     icon: const Icon(
//                       Iconsax.add_circle,
//                       color: AppColors.kPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//               15.sH,
//               StreamBuilder(
//                 stream:
//                     BackEndConfig.teamsCollection.where('event_id', isEqualTo: widget.eventId.toString()).snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No Team Created yet !',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     Text(
//                       'Some Thing Went Wrong 🚫',
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     );
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.kPrimary,
//                         strokeWidth: 5,
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       var team = snapshot.data!.docs[index];
//                       return Card(
//                         elevation: 5,
//                         color: AppColors.kGrey,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               DottedBorder(
//                                 borderType: BorderType.Circle,
//                                 dashPattern: [8],
//                                 radius: const Radius.circular(12),
//                                 padding: const EdgeInsets.all(6),
//                                 strokeWidth: 0.5,
//                                 color: AppColors.kPrimary,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: CachedNetworkImage(
//                                     fit: BoxFit.cover,
//                                     width: 38,
//                                     height: 38,
//                                     imageUrl: team['team_logo'],
//                                     placeholder: (context, url) => Container(
//                                       width: 10,
//                                       height: 10,
//                                       color: AppColors.kGreenColor, // Placeholder background color
//                                       child: const Center(
//                                         child: CircularProgressIndicator(
//                                           color: AppColors.kPrimary,
//                                           // Loader color
//                                         ),
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) => const Icon(Icons.downloading),
//                                   ),
//                                 ),
//                               ),
//                               12.sW,
//                               Text(
//                                 team['team_name'],
//                                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Expanded(
//                                   child: Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 crossAxisAlignment: CrossAxisAlignment.end,
//                                 children: [
//                                   Text(
//                                     'Total Player:\t\t${team['maximum_player'].toString()}',
//                                     style:
//                                         Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
//                                   ),
//                                   TextButton(
//                                     style: TextButton.styleFrom(),
//                                     onPressed: () {
//                                       BHelperFunction.navigate(
//                                         context,
//                                         SelectPlayerScreen(
//                                           maximumPlayer: int.parse(team['maximum_player']),
//                                           teamId: team.id,
//                                           eventId: widget.eventId.toString(),
//                                           teamName: team['team_name'],
//                                           //maximumPlayer:team['maximum_player'].toString(),
//                                         ),
//                                       );
//                                     },
//                                     child: Text(
//                                       'Add Player',
//                                       style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                                             fontWeight: FontWeight.bold,
//                                             color: AppColors.kGreenColor,
//                                           ),
//                                     ),
//                                   ),
//                                 ],
//                               ))
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
/// middle
// import 'dart:io';
//
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:iconsax/iconsax.dart';
// import 'package:unisport_admin_app/utils/const/sizes.dart';
// import 'package:unisport_admin_app/utils/helper/helper_function.dart';
// import 'package:unisport_admin_app/view/home/create_team_view/create_team_screen.dart';
// import 'package:unisport_admin_app/view/home/select_player_view/select_player_screen.dart';
//
// import '../../../utils/const/back_end_config.dart';
// import '../../../utils/const/colors.dart';
//
// class AllTeamScreen extends StatefulWidget {
//   final String eventId;
//   final String eventName;
//   final String eventGameName;
//   final String eventGameId;
//
//   const AllTeamScreen(
//       {super.key,
//         required this.eventId,
//         required this.eventName,
//         required this.eventGameName,
//         required this.eventGameId});
//
//   @override
//   State<AllTeamScreen> createState() => _AllTeamScreenState();
// }
//
// class _AllTeamScreenState extends State<AllTeamScreen> {
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: const Text('Team'),
//       ),
//       body: SingleChildScrollView(
//         child: Padding(
//           padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
//           child: Column(
//             children: [
//               20.sH,
//               Row(
//                 mainAxisAlignment: MainAxisAlignment.spaceBetween,
//                 children: [
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'All Teams\t\t',
//                           style: Theme.of(context).textTheme.titleLarge,
//                         ),
//                         TextSpan(
//                           text: 'º 1',
//                           style: Theme.of(context)
//                               .textTheme
//                               .bodyMedium!
//                               .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold),
//                         ),
//                       ],
//                     ),
//                   ),
//                   IconButton(
//                     onPressed: () {
//                       BHelperFunction.navigate(
//                         context,
//                         CreateTeamScreen(
//                           eventGameID: widget.eventGameId,
//                           eventGameName: widget.eventGameName,
//                           eventName: widget.eventName,
//                           eventId: widget.eventId,
//                         ),
//                       );
//                     },
//                     icon: const Icon(
//                       Iconsax.add_circle,
//                       color: AppColors.kPrimary,
//                     ),
//                   ),
//                 ],
//               ),
//               15.sH,
//               StreamBuilder(
//                 stream:
//                 BackEndConfig.teamsCollection.where('event_id', isEqualTo: widget.eventId.toString()).snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No Team Created yet !',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     Text(
//                       'Some Thing Went Wrong 🚫',
//                       style: Theme.of(context).textTheme.bodyLarge,
//                     );
//                   }
//                   if (snapshot.connectionState == ConnectionState.waiting) {
//                     return const Center(
//                       child: CircularProgressIndicator(
//                         color: AppColors.kPrimary,
//                         strokeWidth: 5,
//                       ),
//                     );
//                   }
//                   return ListView.builder(
//                     itemCount: snapshot.data!.docs.length,
//                     shrinkWrap: true,
//                     itemBuilder: (context, index) {
//                       var team = snapshot.data!.docs[index];
//                       var maximumPlayer = team['maximum_player'];
//                       var currentPlayers = team['current_player_count'] ?? 0;
//
//                       return Card(
//                         elevation: 5,
//                         color: AppColors.kGrey,
//                         child: Padding(
//                           padding: const EdgeInsets.all(8.0),
//                           child: Row(
//                             children: [
//                               DottedBorder(
//                                 borderType: BorderType.Circle,
//                                 dashPattern: [8],
//                                 radius: const Radius.circular(12),
//                                 padding: const EdgeInsets.all(6),
//                                 strokeWidth: 0.5,
//                                 color: AppColors.kPrimary,
//                                 child: ClipRRect(
//                                   borderRadius: BorderRadius.circular(100),
//                                   child: CachedNetworkImage(
//                                     fit: BoxFit.cover,
//                                     width: 38,
//                                     height: 38,
//                                     imageUrl: team['team_logo'],
//                                     placeholder: (context, url) => Container(
//                                       width: 10,
//                                       height: 10,
//                                       color: AppColors.kGreenColor, // Placeholder background color
//                                       child: const Center(
//                                         child: CircularProgressIndicator(
//                                           color: AppColors.kPrimary,
//                                           // Loader color
//                                         ),
//                                       ),
//                                     ),
//                                     errorWidget: (context, url, error) => const Icon(Icons.downloading),
//                                   ),
//                                 ),
//                               ),
//                               12.sW,
//                               Text(
//                                 team['team_name'],
//                                 style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
//                                 maxLines: 1,
//                                 overflow: TextOverflow.ellipsis,
//                               ),
//                               Expanded(
//                                   child: Column(
//                                     mainAxisAlignment: MainAxisAlignment.center,
//                                     crossAxisAlignment: CrossAxisAlignment.end,
//                                     children: [
//                                       Text(
//                                         'Total Player:\t\t$currentPlayers / $maximumPlayer',
//                                         style:
//                                         Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
//                                       ),
//                                       TextButton(
//                                         style: TextButton.styleFrom(),
//                                         onPressed: () {
//                                           if (currentPlayers < maximumPlayer) {
//                                             BHelperFunction.navigate(
//                                               context,
//                                               SelectPlayerScreen(
//                                                 maximumPlayer: maximumPlayer,
//                                                 teamId: team.id,
//                                                 eventId: widget.eventId.toString(),
//                                                 teamName: team['team_name'],
//                                                 //maximumPlayer:team['maximum_player'].toString(),
//                                               ),
//                                             );
//                                           }
//                                         },
//                                         child: Text(
//                                           currentPlayers < maximumPlayer ? 'Add Player' : 'Player Full',
//                                           style: Theme.of(context).textTheme.labelMedium!.copyWith(
//                                             fontWeight: FontWeight.bold,
//                                             color: currentPlayers < maximumPlayer ? AppColors.kGreenColor : Colors.red,
//                                           ),
//                                         ),
//                                       ),
//                                     ],
//                                   ))
//                             ],
//                           ),
//                         ),
//                       );
//                     },
//                   );
//                 },
//               ),
//             ],
//           ),
//         ),
//       ),
//     );
//   }
// }
import 'dart:io';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:iconsax/iconsax.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';
import 'package:unisport_admin_app/view/home/create_team_view/create_team_screen.dart';
import 'package:unisport_admin_app/view/home/select_player_view/select_player_screen.dart';

import '../../../utils/const/back_end_config.dart';
import '../../../utils/const/colors.dart';

class AllTeamScreen extends StatefulWidget {
  final String eventId;
  final String eventName;
  final String eventGameName;
  final String eventGameId;

  const AllTeamScreen(
      {super.key,
      required this.eventId,
      required this.eventName,
      required this.eventGameName,
      required this.eventGameId});

  @override
  State<AllTeamScreen> createState() => _AllTeamScreenState();
}

class _AllTeamScreenState extends State<AllTeamScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Team'),
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace),
          child: Column(
            children: [
              20.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'All Teams\t\t',
                          style: Theme.of(context).textTheme.titleLarge,
                        ),
                        TextSpan(
                          text: 'º 1',
                          style: Theme.of(context)
                              .textTheme
                              .bodyMedium!
                              .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold),
                        ),
                      ],
                    ),
                  ),
                  IconButton(
                    onPressed: () {
                      BHelperFunction.navigate(
                        context,
                        CreateTeamScreen(
                          eventGameID: widget.eventGameId,
                          eventGameName: widget.eventGameName,
                          eventName: widget.eventName,
                          eventId: widget.eventId,
                        ),
                      );
                    },
                    icon: const Icon(
                      Iconsax.add_circle,
                      color: AppColors.kPrimary,
                    ),
                  ),
                ],
              ),
              15.sH,
              StreamBuilder(
                stream:
                    BackEndConfig.teamsCollection.where('event_id', isEqualTo: widget.eventId.toString()).snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Team Created yet !',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  }
                  if (snapshot.hasError) {
                    return Text(
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
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var team = snapshot.data!.docs[index];
                      int maximumPlayer;
                      try {
                        maximumPlayer = team['maximum_player'] is String
                            ? int.parse(team['maximum_player'])
                            : team['maximum_player'];
                      } catch (e) {
                        maximumPlayer = 0; // Default to 0 if parsing fails
                      }

                      return Card(
                        elevation: 5,
                        color: AppColors.kGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: FutureBuilder(
                            future: BackEndConfig.teamsCollection.doc(team.id).collection('players').get(),
                            builder: (context, playerSnapshot) {
                              if (playerSnapshot.connectionState == ConnectionState.waiting) {
                                return const Center(
                                  child: CircularProgressIndicator(
                                    color: AppColors.kPrimary,
                                    strokeWidth: 2,
                                  ),
                                );
                              }
                              if (playerSnapshot.hasError) {
                                return Text(
                                  'Error loading players 🚫',
                                  style: Theme.of(context).textTheme.bodyLarge,
                                );
                              }

                              int currentPlayers = playerSnapshot.data?.docs.length ?? 0;

                              return Row(
                                children: [
                                  DottedBorder(
                                    borderType: BorderType.Circle,
                                    dashPattern: [8],
                                    radius: const Radius.circular(12),
                                    padding: const EdgeInsets.all(6),
                                    strokeWidth: 0.5,
                                    color: AppColors.kPrimary,
                                    child: ClipRRect(
                                      borderRadius: BorderRadius.circular(100),
                                      child: CachedNetworkImage(
                                        fit: BoxFit.cover,
                                        width: 38,
                                        height: 38,
                                        imageUrl: team['team_logo'],
                                        placeholder: (context, url) => Container(
                                          width: 10,
                                          height: 10,
                                          color: AppColors.kGreenColor, // Placeholder background color
                                          child: const Center(
                                            child: CircularProgressIndicator(
                                              color: AppColors.kPrimary,
                                              // Loader color
                                            ),
                                          ),
                                        ),
                                        errorWidget: (context, url, error) => const Icon(Icons.downloading),
                                      ),
                                    ),
                                  ),
                                  12.sW,
                                  Text(
                                    team['team_name'],
                                    style:
                                        Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                                    maxLines: 1,
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                  Expanded(
                                      child: Column(
                                    mainAxisAlignment: MainAxisAlignment.center,
                                    crossAxisAlignment: CrossAxisAlignment.end,
                                    children: [
                                      Text(
                                        'Total Player:\t\t$currentPlayers / $maximumPlayer',
                                        style: Theme.of(context)
                                            .textTheme
                                            .labelMedium!
                                            .copyWith(fontWeight: FontWeight.w600),
                                      ),
                                      TextButton(
                                        style: TextButton.styleFrom(),
                                        onPressed: currentPlayers < maximumPlayer
                                            ? () {
                                                BHelperFunction.navigate(
                                                  context,
                                                  SelectPlayerScreen(
                                                    maximumPlayer: maximumPlayer,
                                                    teamId: team.id,
                                                    eventId: widget.eventId.toString(),
                                                    teamName: team['team_name'],
                                                  ),
                                                );
                                              }
                                            : null,
                                        child: Text(
                                          currentPlayers < maximumPlayer ? 'Add Player' : 'Player Full',
                                          style: Theme.of(context).textTheme.labelMedium!.copyWith(
                                                fontWeight: FontWeight.bold,
                                                color:
                                                    currentPlayers < maximumPlayer ? AppColors.kGreenColor : Colors.red,
                                              ),
                                        ),
                                      ),
                                    ],
                                  ))
                                ],
                              );
                            },
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
