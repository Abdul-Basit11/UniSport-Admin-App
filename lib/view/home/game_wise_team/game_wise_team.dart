import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:unisport_admin_app/utils/const/back_end_config.dart';
import 'package:unisport_admin_app/utils/const/colors.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';

class GamesTabScreen extends StatefulWidget {
  @override
  _GamesTabScreenState createState() => _GamesTabScreenState();
}

class _GamesTabScreenState extends State<GamesTabScreen> with SingleTickerProviderStateMixin {
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
        title: const Text('Your All Teams'),
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
          ? const Center(child: CircularProgressIndicator())
          : _games.isEmpty
              ? const Center(child: Text('No games available !'))
              : TabBarView(
                  controller: _tabController,
                  children: _games.map((game) {
                    return GameDetailTab(game: game);
                  }).toList(),
                ),
    );
  }
}

class GameDetailTab extends StatelessWidget {
  final QueryDocumentSnapshot game;

  const GameDetailTab({Key? key, required this.game}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(16.0),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: kToolbarHeight),
          StreamBuilder(
            stream: BackEndConfig.teamsCollection.where('event_game_id', isEqualTo: game['game_id']).snapshots(),
            builder: (context, snapshot) {
              if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                return Center(
                  child: Text(
                    'No Team Created for ${game['game_name']} game',
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
                itemCount: snapshot.data!.docs.length,
                shrinkWrap: true,
                itemBuilder: (context, index) {
                  var team = snapshot.data!.docs[index];
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
                            strokeWidth: 1,
                            color: AppColors.kPrimary,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(100),
                              child: CachedNetworkImage(
                                fit: BoxFit.cover,
                                width: 40,
                                height: 40,
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
                            style: Theme.of(context).textTheme.bodyMedium!.copyWith(fontWeight: FontWeight.w600),
                            maxLines: 1,
                            overflow: TextOverflow.ellipsis,
                          ),
                          Expanded(
                              child: Column(
                            mainAxisAlignment: MainAxisAlignment.center,
                            crossAxisAlignment: CrossAxisAlignment.end,
                            children: [
                              Text(
                                'Total Player:\t\t${team['maximum_player'].toString()}',
                                style: Theme.of(context).textTheme.labelMedium!.copyWith(fontWeight: FontWeight.w600),
                              ),
                              // TextButton(
                              //   style: TextButton.styleFrom(),
                              //   onPressed: () {
                              //     BHelperFunction.navigate(
                              //       context,
                              //       SelectPlayerScreen(
                              //         maximumPlayer: int.parse(team['maximum_player']),
                              //         teamId: team.id,
                              //         teamName: team['team_name'],
                              //         //maximumPlayer:team['maximum_player'].toString(),
                              //       ),
                              //     );
                              //   },
                              //   child: Text(
                              //     'Add Player',
                              //     style: Theme.of(context).textTheme.labelMedium!.copyWith(
                              //       fontWeight: FontWeight.bold,
                              //       color: AppColors.kGreenColor,
                              //     ),
                              //   ),
                              // ),
                            ],
                          ))
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
      ),
    );
  }
}
