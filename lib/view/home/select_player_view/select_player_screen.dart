// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:unisport_admin_app/utils/const/sizes.dart';
//
// import '../../../utils/const/back_end_config.dart';
// import '../../../utils/const/colors.dart';
// import '../../../utils/const/image_string.dart';
//
// class SelectPlayerScreen extends StatelessWidget {
//   final String maximumPlayer;
//   const SelectPlayerScreen({super.key, required this.maximumPlayer});
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Select Player'),
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
//                   Text(
//                     'Team Name',
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Selected Player\t\t',
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         TextSpan(
//                           text: '\t1/${maximumPlayer.toString()}',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineSmall!
//                               .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               25.sH,
//               StreamBuilder(
//                 stream: BackEndConfig.applyGamesCollection.where('isApproved', isEqualTo: true).snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No Player for ',
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
//                       var data = snapshot.data!.docs[index];
//                       return Card(
//                         elevation: 5,
//                         color: AppColors.kGrey,
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
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
//                                   child: data['player_image'] == ''
//                                       ? Image.asset(
//                                           ImageString.placeholder,
//                                           fit: BoxFit.cover,
//                                           height: 35,
//                                           width: 35,
//                                         )
//                                       : CachedNetworkImage(
//                                           fit: BoxFit.cover,
//                                           width: 38,
//                                           height: 38,
//                                           imageUrl: data['player_image'].toString(),
//                                           placeholder: (context, url) => Container(
//                                             width: 10,
//                                             height: 10,
//                                             color: AppColors.kGreenColor, // Placeholder background color
//                                             child: const Center(
//                                               child: CircularProgressIndicator(
//                                                 color: AppColors.kPrimary,
//                                                 // Loader color
//                                               ),
//                                             ),
//                                           ),
//                                           errorWidget: (context, url, error) => const Icon(Icons.downloading),
//                                         ),
//                                 ),
//                               ),
//                               12.sW,
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       data['apply_player_name'],
//                                       style:
//                                           Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Text(
//                                       data['player_department_name'],
//                                       style: Theme.of(context).textTheme.labelMedium,
//                                       maxLines: 1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Radio(
//                                 value: true,
//                                 groupValue: '',
//                                 onChanged: (v) {},
//                               ),
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
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: () {},
//         label: Text('Add'),
//       ),
//     );
//   }
// }

/// 2
// import 'package:cached_network_image/cached_network_image.dart';
// import 'package:dotted_border/dotted_border.dart';
// import 'package:flutter/material.dart';
// import 'package:unisport_admin_app/utils/const/sizes.dart';
//
// import '../../../utils/const/back_end_config.dart';
// import '../../../utils/const/colors.dart';
// import '../../../utils/const/image_string.dart';
//
// class SelectPlayerScreen extends StatefulWidget {
//   final String maximumPlayer;
//   const SelectPlayerScreen({super.key, required this.maximumPlayer});
//
//   @override
//   _SelectPlayerScreenState createState() => _SelectPlayerScreenState();
// }
//
// class _SelectPlayerScreenState extends State<SelectPlayerScreen> {
//   int selectedPlayersCount = 0;
//   List<String> selectedPlayers = [];
//
//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       appBar: AppBar(
//         centerTitle: true,
//         title: Text('Select Player'),
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
//                   Text(
//                     'Team Name',
//                     style: Theme.of(context).textTheme.bodyLarge,
//                   ),
//                   Text.rich(
//                     TextSpan(
//                       children: [
//                         TextSpan(
//                           text: 'Selected Player\t\t',
//                           style: Theme.of(context).textTheme.bodyLarge,
//                         ),
//                         TextSpan(
//                           text: '\t$selectedPlayersCount/${widget.maximumPlayer}',
//                           style: Theme.of(context)
//                               .textTheme
//                               .headlineSmall!
//                               .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.w500),
//                         ),
//                       ],
//                     ),
//                   ),
//                 ],
//               ),
//               25.sH,
//               StreamBuilder(
//                 stream: BackEndConfig.applyGamesCollection.where('isApproved', isEqualTo: true).snapshots(),
//                 builder: (context, snapshot) {
//                   if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
//                     return Center(
//                       child: Text(
//                         'No Player for ',
//                         textAlign: TextAlign.center,
//                         style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
//                       ),
//                     );
//                   }
//                   if (snapshot.hasError) {
//                     return Text(
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
//                       var data = snapshot.data!.docs[index];
//                       bool isSelected = selectedPlayers.contains(data.id);
//                       return Card(
//                         elevation: 5,
//                         color: AppColors.kGrey,
//                         child: Padding(
//                           padding: EdgeInsets.all(8.0),
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
//                                   child: data['player_image'] == ''
//                                       ? Image.asset(
//                                           ImageString.placeholder,
//                                           fit: BoxFit.cover,
//                                           height: 35,
//                                           width: 35,
//                                         )
//                                       : CachedNetworkImage(
//                                           fit: BoxFit.cover,
//                                           width: 38,
//                                           height: 38,
//                                           imageUrl: data['player_image'].toString(),
//                                           placeholder: (context, url) => Container(
//                                             width: 10,
//                                             height: 10,
//                                             color: AppColors.kGreenColor, // Placeholder background color
//                                             child: const Center(
//                                               child: CircularProgressIndicator(
//                                                 color: AppColors.kPrimary,
//                                                 // Loader color
//                                               ),
//                                             ),
//                                           ),
//                                           errorWidget: (context, url, error) => const Icon(Icons.downloading),
//                                         ),
//                                 ),
//                               ),
//                               12.sW,
//                               Expanded(
//                                 child: Column(
//                                   crossAxisAlignment: CrossAxisAlignment.start,
//                                   children: [
//                                     Text(
//                                       data['apply_player_name'],
//                                       style:
//                                           Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
//                                       maxLines: 1,
//                                       overflow: TextOverflow.ellipsis,
//                                     ),
//                                     Text(
//                                       data['player_department_name'],
//                                       style: Theme.of(context).textTheme.labelMedium,
//                                       maxLines: 1,
//                                     ),
//                                   ],
//                                 ),
//                               ),
//                               Checkbox(
//                                 shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(50)),
//                                 value: isSelected,
//                                 onChanged: (value) {
//                                   setState(() {
//                                     if (value == true) {
//                                       if (selectedPlayersCount < int.parse(widget.maximumPlayer)) {
//                                         selectedPlayers.add(data.id);
//                                         selectedPlayersCount++;
//                                       }
//                                     } else {
//                                       selectedPlayers.remove(data.id);
//                                       selectedPlayersCount--;
//                                     }
//                                   });
//                                 },
//                               ),
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
//       floatingActionButton: FloatingActionButton.extended(
//         onPressed: selectedPlayersCount <= int.parse(widget.maximumPlayer) ? () {} : null,
//         label: Text('Add'),
//       ),
//     );
//   }
// }

/// 3
import 'package:cached_network_image/cached_network_image.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/loaders/loaders.dart';

import '../../../utils/const/back_end_config.dart';
import '../../../utils/const/colors.dart';
import '../../../utils/const/image_string.dart';

class SelectPlayerScreen extends StatefulWidget {
  final String teamId;
  final String eventId;
  final String teamName;
  final int maximumPlayer;

  const SelectPlayerScreen(
      {super.key, required this.teamId, required this.maximumPlayer, required this.teamName, required this.eventId});

  @override
  _SelectPlayerScreenState createState() => _SelectPlayerScreenState();
}

class _SelectPlayerScreenState extends State<SelectPlayerScreen> {
  Set<String> selectedPlayerIds = {};

  Future<void> _addSelectedPlayers() async {
    if (selectedPlayerIds.length != widget.maximumPlayer) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(content: Text('You must select exactly ${widget.maximumPlayer} players.')),
      );
      return;
    }

    var teamDoc = BackEndConfig.teamsCollection.doc(widget.teamId);

    // Get the current list of players in the team
    var teamSnapshot = await teamDoc.get();
    var currentPlayers = List<String>.from(teamSnapshot['players']);

    if (currentPlayers.length + selectedPlayerIds.length <= widget.maximumPlayer) {
      for (var playerId in selectedPlayerIds) {
        currentPlayers.add(playerId);
      }

      await teamDoc.update({'players': currentPlayers});
      Loaders.successSnackBar(
          title: 'Success', messagse: 'Players added successfully in [ Team  ${widget.teamName} ] !');

      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Players added successfully!')),
      // );

      setState(() {
        selectedPlayerIds.clear();
      });
    } else {
      Loaders.warningSnackBar(title: 'Warning', messagse: 'Cannot add more players. Maximum limit reached.');
      // ScaffoldMessenger.of(context).showSnackBar(
      //   const SnackBar(content: Text('Cannot add more players. Maximum limit reached.')),
      // );
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        centerTitle: true,
        title: const Text('Select Player'),
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
                  Text(
                    'Team Name',
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text.rich(
                    TextSpan(
                      children: [
                        TextSpan(
                          text: 'Selected Player\t\t',
                          style: Theme.of(context).textTheme.bodyLarge,
                        ),
                        TextSpan(
                          text: '\t${selectedPlayerIds.length}/${widget.maximumPlayer}',
                          style: Theme.of(context)
                              .textTheme
                              .headlineSmall!
                              .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.w500),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              25.sH,
              StreamBuilder(
                stream: BackEndConfig.applyGamesCollection
                    .where('isApproved', isEqualTo: true)
                    .where('event_id', isEqualTo: widget.eventId.toString())
                    .snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimary,
                        strokeWidth: 5,
                      ),
                    );
                  }

                  if (snapshot.hasError) {
                    return Center(
                      child: Text(
                        'Something went wrong 🚫',
                        style: Theme.of(context).textTheme.bodyLarge,
                      ),
                    );
                  }

                  if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Player for ',
                        textAlign: TextAlign.center,
                        style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
                      ),
                    );
                  }

                  return ListView.builder(
                    itemCount: snapshot.data!.docs.length,
                    shrinkWrap: true,
                    itemBuilder: (context, index) {
                      var data = snapshot.data!.docs[index];
                      var playerId = data.id;

                      return Card(
                        elevation: 5,
                        color: AppColors.kGrey,
                        child: Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Row(
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
                                  child: data['player_image'] == ''
                                      ? Image.asset(
                                          ImageString.placeholder,
                                          fit: BoxFit.cover,
                                          height: 35,
                                          width: 35,
                                        )
                                      : CachedNetworkImage(
                                          fit: BoxFit.cover,
                                          width: 38,
                                          height: 38,
                                          imageUrl: data['player_image'].toString(),
                                          placeholder: (context, url) => Container(
                                            width: 10,
                                            height: 10,
                                            color: AppColors.kGreenColor, // Placeholder background color
                                            child: const Center(
                                              child: CircularProgressIndicator(
                                                color: AppColors.kPrimary,
                                              ),
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
                                      data['apply_player_name'],
                                      style: Theme.of(context).textTheme.bodyMedium!.copyWith(
                                            fontWeight: FontWeight.w600,
                                          ),
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    Text(
                                      data['player_department_name'],
                                      style: Theme.of(context).textTheme.labelMedium,
                                      maxLines: 1,
                                    ),
                                  ],
                                ),
                              ),
                              Checkbox(
                                value: selectedPlayerIds.contains(playerId),
                                onChanged: (bool? value) {
                                  setState(() {
                                    if (value == true) {
                                      if (selectedPlayerIds.length < widget.maximumPlayer) {
                                        selectedPlayerIds.add(playerId);
                                      } else {
                                        ScaffoldMessenger.of(context).showSnackBar(
                                          SnackBar(
                                            content: Text('You can only select up to ${widget.maximumPlayer} players.'),
                                          ),
                                        );
                                      }
                                    } else {
                                      selectedPlayerIds.remove(playerId);
                                    }
                                  });
                                },
                              ),
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
      floatingActionButton: FloatingActionButton.extended(
        onPressed: selectedPlayerIds.length == widget.maximumPlayer ? _addSelectedPlayers : null,
        label: const Text('Add Players'),
      ),
    );
  }
}
