import 'package:cached_network_image/cached_network_image.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_secure_storage/flutter_secure_storage.dart';
import 'package:get/get.dart';
import 'package:get/get_instance/get_instance.dart';
import 'package:iconsax/iconsax.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:unisport_admin_app/controller/event_controller.dart';
import 'package:unisport_admin_app/utils/const/colors.dart';
import 'package:unisport_admin_app/utils/const/image_string.dart';
import 'package:unisport_admin_app/utils/const/sizes.dart';
import 'package:unisport_admin_app/utils/helper/helper_function.dart';
import 'package:unisport_admin_app/utils/loaders/loaders.dart';
import 'package:unisport_admin_app/utils/widgets/custom_button.dart';
import 'package:unisport_admin_app/view/home/add_event_view/add_event_screen.dart';
import 'package:unisport_admin_app/view/home/event_detail_view/event_detail_screen.dart';
import 'package:unisport_admin_app/view/home/game_detail_view/game_detail_screen.dart';

import '../../../utils/const/back_end_config.dart';
import '../../../utils/widgets/custom_divider.dart';
import '../../../utils/widgets/image_builder_widget.dart';
import 'widget/dashboard_cards.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  PageController pagecontroller = PageController();

  @override
  void initState() {
    super.initState();
    getCurrentUser();
    _regPlayerID();
  }

  final storage = const FlutterSecureStorage();

  _regPlayerID() async {
    try {
      // var status = await OneSignal.shared.getPermissionSubscriptionState();
      // final tokenID = status.subscriptionStatus.userId;
      final tokenID = OneSignal.User.pushSubscription.id;
      if (tokenID != null) {
        String playerID = await storage.read(key: "playerID") ?? "";
        if (playerID != tokenID) {
          var currentUser = FirebaseAuth.instance.currentUser;
          if (currentUser != null) {
            String uid = currentUser.uid;
            print("Current User UID: $uid");

            await FirebaseFirestore.instance.collection('tokens').doc(uid).set(
              {'id': tokenID},
              SetOptions(merge: true),
            );

            await storage.write(key: "playerID", value: tokenID);
            Loaders.successSnackBar(title: 'Stored ID Successfully');
            print('Player ID stored successfully');
          } else {
            print('No authenticated user found');
          }
        } else {
          print('Player ID is already up to date');
        }
      } else {
        print('Failed to retrieve player ID from OneSignal');
      }
    } catch (e) {
      print('Error in _regPlayerID: $e');
    }
  }

  // _regPlayerID() async {
  //   final tokenID = OneSignal.User.pushSubscription.id;
  //   if (tokenID != null) {
  //     String palyeriD = await storage.read(key: "playerID") ?? "";
  //     if (palyeriD != tokenID) {
  //       ///update token in firebase
  //       FirebaseFirestore.instance.collection('tokens').doc(FirebaseAuth.instance.currentUser!.uid).set(
  //           {
  //             'id': tokenID,
  //           },
  //           SetOptions(
  //             merge: true,
  //           )).then((value) {
  //         storage.write(key: "playerID", value: tokenID);
  //       });
  //     }
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    final dark = BHelperFunction.isDarkMode(context);

    final eventController = Get.put(EventController());
    return Scaffold(
      appBar: AppBar(
        automaticallyImplyLeading: false,
        title: Row(
          children: [
            Text(
              'Status: ',
              style: Theme.of(context).textTheme.bodyMedium,
            ),
            Text(
              'ADMIN',
              style: Theme.of(context).textTheme.titleMedium,
            ),
          ],
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 8.0),
            child: DottedBorder(
              borderType: BorderType.Circle,
              dashPattern: [8],
              radius: const Radius.circular(12),
              padding: const EdgeInsets.all(6),
              color: Colors.white,
              child: image == ''
                  ? ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: Image.asset(
                        ImageString.placeholder,
                        fit: BoxFit.cover,
                      ),
                    )
                  : ClipRRect(
                      borderRadius: BorderRadius.circular(60),
                      child: ImageBuilderWidget(
                        height: 45,
                        width: 45,
                        image: image.toString(),
                      ),
                    ),
            ),
          )
        ],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: AppSizes.defaultSpace / 2),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              20.sH,
              FutureBuilder(
                future: eventController.getCounts(),
                builder: (context, AsyncSnapshot snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return const Center(
                      child: CircularProgressIndicator(
                        color: AppColors.kPrimary,
                      ),
                    );
                  }
                  if (!snapshot.hasData) {
                    return const SizedBox();
                  }

                  var countData = snapshot.data;
                  return Column(
                    children: [
                      Row(
                        children: [
                          DashboardCards(title: 'Total Events', subtitle: countData[0].toString()),
                          10.sW,
                          DashboardCards(title: 'Total Games', subtitle: countData[1].toString()),
                        ],
                      ),
                    ],
                  );
                },
              ),
              20.sH,
              const CustomDivider(),
              10.sH,
              StreamBuilder<QuerySnapshot>(
                stream: BackEndConfig.bannerCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.connectionState == ConnectionState.waiting) {
                    return Center(child: CircularProgressIndicator());
                  } else if (snapshot.hasError) {
                    return Center(child: Text('Something went wrong!'));
                  } else if (!snapshot.hasData || snapshot.data!.docs.isEmpty) {
                    return Center(child: Text('No Banners available.'));
                  } else {
                    List<DocumentSnapshot> docs = snapshot.data!.docs;
                    return Column(
                      children: [
                        SizedBox(
                          height: 155,
                          width: double.infinity,
                          child: PageView.builder(
                            itemCount: docs.length,
                            controller: pagecontroller,
                            itemBuilder: (context, index) {
                              var data = docs[index];
                              return Padding(
                                padding: const EdgeInsets.all(4.0),
                                child: ClipRRect(
                                  borderRadius: BorderRadius.circular(15),
                                  child: CachedNetworkImage(
                                    fit: BoxFit.cover,
                                    width: BHelperFunction.screenWidth() * 0.4,
                                    height: 155,
                                    imageUrl: data['banner'],
                                    placeholder: (context, url) => Container(
                                      width: 10,
                                      height: 10,
                                      color: AppColors.kPrimary.withOpacity(0.2), // Placeholder background color
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
                              );
                            },
                          ),
                        ),
                        15.sH,
                        Container(
                          alignment: Alignment.center,
                          height: 30,
                          width: double.infinity,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(AppSizes.sm),
                            color: dark ? AppColors.kwhite.withOpacity(0.1) : AppColors.kblack.withOpacity(0.1),
                          ),
                          child: SmoothPageIndicator(
                            controller: pagecontroller,
                            count: docs.length,
                            effect: const ExpandingDotsEffect(
                              dotHeight: 5,
                              dotWidth: 20,
                              activeDotColor: AppColors.kPrimary,
                              dotColor: AppColors.kblack,
                            ),
                          ),
                        ),
                      ],
                    );
                  }
                },
              ),
              10.sH,
              Text(
                'Games\t\t',
                style: Theme.of(context).textTheme.titleLarge,
              ),
              20.sH,
              StreamBuilder(
                stream: BackEndConfig.gamesCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Game Added yet !',
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.15,
                    child: ListView.builder(
                      itemCount: snapshot.data!.docs.length,
                      shrinkWrap: true,
                      scrollDirection: Axis.horizontal,
                      itemBuilder: (context, index) {
                        var game = snapshot.data!.docs[index];
                        return Padding(
                          padding: const EdgeInsets.only(right: 15),
                          child: CupertinoButton(
                            onPressed: () {
                              BHelperFunction.navigate(
                                context,
                                GameDetailScreen(
                                  gameId: game['game_id'],
                                  gameName: game['game_name'],
                                ),
                              );
                            },
                            padding: EdgeInsets.zero,
                            child: Column(
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
                                      imageUrl: game['game_logo'],
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
                                8.sH,
                                SizedBox(
                                  width: 70,
                                  child: Text(
                                    game['game_name'],
                                    textAlign: TextAlign.center,
                                    style:
                                        Theme.of(context).textTheme.labelLarge!.copyWith(fontWeight: FontWeight.w500),
                                    overflow: TextOverflow.ellipsis,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
              const CustomDivider(),
              10.sH,
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    'Events\t\t',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                ],
              ),
              15.sH,
              StreamBuilder(
                stream: BackEndConfig.eventsCollection.snapshots(),
                builder: (context, snapshot) {
                  if (snapshot.data == null || snapshot.data!.docs.isEmpty) {
                    return Center(
                      child: Text(
                        'No Event Added yet !',
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
                  return SizedBox(
                    height: MediaQuery.of(context).size.height * 0.165,
                    child: ListView.builder(
                      shrinkWrap: true,
                      primary: false,
                      scrollDirection: Axis.horizontal,
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
                            padding: const EdgeInsets.symmetric(horizontal: 8),
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
                                      style: Theme.of(context)
                                          .textTheme
                                          .labelMedium!
                                          .copyWith(fontWeight: FontWeight.bold),
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(fontWeight: FontWeight.bold),
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
                                              style: Theme.of(context)
                                                  .textTheme
                                                  .labelSmall!
                                                  .copyWith(fontWeight: FontWeight.bold),
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
                    ),
                  );
                },
              ),
              const SizedBox(height: kToolbarHeight * 1.35),
            ],
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          BHelperFunction.navigate(context, ADDEventScreen());
        },
        label: const Text('Add Events'),
      ),
    );
  }

  String? image;

  getCurrentUser() {
    BackEndConfig.adminsCollection
        .doc(FirebaseAuth.instance.currentUser!.uid)
        .snapshots()
        .listen((DocumentSnapshot documentSnapshot) {
      setState(() {});
      image = documentSnapshot.get('image');
    });
  }
}
