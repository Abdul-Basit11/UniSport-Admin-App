import 'package:permission_handler/permission_handler.dart';

class NotificationPermision {
  Future<void> requestPermission() async {
    PermissionStatus status = await Permission.notification.request();
    if (status != PermissionStatus.granted) {
      print('Permission not granted');
    }
  }
}

// import 'package:permission_handler/permission_handler.dart';
//
// Future<void> requestNotificationPermission() async {
//   PermissionStatus status = await Permission.notification.request();
//
//   switch (status) {
//     case PermissionStatus.granted:
//       // Permission granted, you can send notifications
//       print('Notification Permission granted.');
//       break;
//     case PermissionStatus.denied:
//       // Permission denied, you might ask the user to allow it from settings manually
//       print('Notification Permission denied.');
//       // Optionally, show an alert dialog or another form of UI here to guide the user
//       break;
//     case PermissionStatus.permanentlyDenied:
//       // Permissions are permanently denied, open app settings
//       print('Notification Permission are permanently denied. Redirecting to settings...');
//       openAppSettings(); // You can guide users to the settings for manual configuration
//       break;
//     case PermissionStatus.restricted:
//       // Restricted, this is generally for iOS when the permission is restricted by parental control
//       print('Notification Permission is restricted by parental controls or system settings.');
//       break;
//     case PermissionStatus.limited:
//       // Permission is limited, not usually applicable for notifications but handled for completeness
//       print('Notification Permission is limited.');
//       break;
//     case PermissionStatus.provisional:
//     // TODO: Handle this case.
//   }
// }
