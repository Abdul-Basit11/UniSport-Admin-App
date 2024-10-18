import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/const/back_end_config.dart';
import 'package:unisport_admin_app/utils/const/colors.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';

import '../../../utils/helper/helper_function.dart';
import '../event_detail_view/event_detail_screen.dart';

class GameWiseEvents extends StatefulWidget {
  @override
  _GameWiseEventsState createState() => _GameWiseEventsState();
}

class _GameWiseEventsState extends State<GameWiseEvents> with SingleTickerProviderStateMixin {
  late TabController _tabController;
  List<QueryDocumentSnapshot> _games = [];
  bool _isLoading = true;

  @override
  void initState() {
    super.initState();
    _fetchGames();
  }

  Future<void> _fetchGames() async {
    try {
      QuerySnapshot querySnapshot = await FirebaseFirestore.instance.collection('games').get();
      setState(() {
        _games = querySnapshot.docs;
        _tabController = TabController(length: _games.length, vsync: this);
        _isLoading = false;
      });
    } catch (e) {
      print('Error fetching games: $e');
      setState(() {
        _isLoading = false;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Your All Events'),
        bottom: _isLoading
            ? null
            : _games.isEmpty
                ? null
                : TabBar(
                    labelStyle: TextStyle(fontSize: 14, fontWeight: FontWeight.bold),
                    unselectedLabelStyle: TextStyle(fontWeight: FontWeight.w400, fontSize: 14),
                    indicatorSize: TabBarIndicatorSize.tab,
                    padding: EdgeInsets.all(0),
                    indicator: BoxDecoration(borderRadius: BorderRadius.circular(12), color: AppColors.kPrimary),
                    controller: _tabController,
                    isScrollable: true,
                    tabs: _games.map((game) {
                      return Tab(
                        height: 40,
                        child: Text(game['game_name']),
                      );
                    }).toList(),
                  ),
      ),
      body: _isLoading
          ? Center(child: CircularProgressIndicator())
          : _games.isEmpty
              ? const Center(child: Text('No games available !'))
              : TabBarView(
                  controller: _tabController,
                  children: _games.map((game) {
                    return EventDetailTab(game: game);
                  }).toList(),
                ),
    );
  }
}

class EventDetailTab extends StatelessWidget {
  final QueryDocumentSnapshot game;

  const EventDetailTab({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        SizedBox(height: kToolbarHeight),
        StreamBuilder(
          stream: BackEndConfig.eventsCollection
              .where('admin_uid', isEqualTo: FirebaseAuth.instance.currentUser!.uid)
              .where('event_game_id', isEqualTo: game['game_id'])
              .snapshots(),
          builder: (context, snapshot) {
            if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
              return Center(
                child: Text(
                  'No Event Created for ${game['game_name']} game',
                  textAlign: TextAlign.center,
                  style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
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
                var eventData = snapshot.data!.docs[index];
                return CupertinoButton(
                  onPressed: () {
                    BHelperFunction.navigate(
                      context,
                      EventDetailScreen(
                        data: eventData,
                      ),
                    );
                  },
                  padding: EdgeInsets.zero,
                  child: Container(
                    margin: const EdgeInsets.only(right: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 8),
                    width: MediaQuery.of(context).size.width * 0.8,
                    decoration: BoxDecoration(color: AppColors.kGrey, borderRadius: BorderRadius.circular(12)),
                    child: Row(
                      children: [
                        ClipRRect(
                          clipBehavior: Clip.antiAlias,
                          borderRadius: BorderRadius.circular(12),
                          child: CachedNetworkImage(
                            fit: BoxFit.cover,
                            width: 100,
                            height: 90,
                            imageUrl: eventData['event_image'].toString(),
                            placeholder: (context, url) => Container(
                              width: 60,
                              height: 60,
                              color: AppColors.kGreenColor, // Placeholder background color
                              child: const Center(
                                child: CircularProgressIndicator(
                                  color: AppColors.kPrimary, // Loader color
                                ),
                              ),
                            ),
                            errorWidget: (context, url, error) => const Icon(Icons.error),
                          ),
                        ),
                        12.sW,
                        Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Text(
                              eventData['event_name'],
                              style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.bold),
                            ),
                            Text.rich(
                              TextSpan(
                                children: [
                                  TextSpan(
                                      text: 'Games:\t',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: AppColors.kSecondary, fontWeight: FontWeight.bold)),
                                  TextSpan(
                                      text: eventData['event_game_name'],
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(color: AppColors.kPrimary, fontWeight: FontWeight.bold)),
                                ],
                              ),
                            ),
                            10.sH,
                            Row(
                              children: [
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Event Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      eventData['event_date'],
                                      style:
                                          Theme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                                15.sW,
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    Text(
                                      'Event Date',
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(fontWeight: FontWeight.bold),
                                    ),
                                    Text(
                                      eventData['event_time'],
                                      style:
                                          Theme.of(context).textTheme.labelSmall!.copyWith(fontWeight: FontWeight.bold),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        )
                      ],
                    ),
                  ),
                );
              },
            );
          },
        ),
        // Text(
        //   game['game_name'],
        //   style: Theme.of(context).textTheme.titleSmall,
        // ),
        // const SizedBox(height: 8.0),
        // Text(
        //   '',
        //   style: Theme.of(context).textTheme.bodySmall,
        // ),
        // Add more details about the game here
      ],
    );
  }
}
