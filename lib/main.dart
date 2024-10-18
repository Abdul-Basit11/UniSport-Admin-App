import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:get/get_navigation/src/root/get_material_app.dart';
import 'package:get_storage/get_storage.dart';
import 'package:unisport_admin_app/services/theme_services.dart';
import 'package:unisport_admin_app/utils/exception/notification_permission.dart';
import 'package:unisport_admin_app/utils/theme/theme.dart';
import 'package:unisport_admin_app/view/authentication/splash_screen/splash_screen.dart';
import 'package:onesignal_flutter/onesignal_flutter.dart';
import 'firebase_options.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await GetStorage.init();
  await NotificationPermision().requestPermission();
  OneSignal.Debug.setLogLevel(OSLogLevel.verbose);
  OneSignal.initialize('1108f2cd-f8b5-4d2f-9fcf-e42b4b9c8dd0');
  OneSignal.Notifications.addClickListener((OSNotificationClickEvent event) {
    if (event.notification.additionalData!["custom_data"]["NOTIFICATION_TYPE"] == "MESSAGE_NOTIFICATION") {
    } else {}
  });
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({super.key});

  @override
  State<MyApp> createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  @override
  Widget build(BuildContext context) {
    return GetMaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'UniSport Admin App',
      theme: AppTheme.lightTheme(context),
      darkTheme: AppTheme.darkTheme(context),
      themeMode: ThemeService().getThemeMode(),
      home: SplashScreen(),
    );
  }
}
