// import 'dart:io';
// import 'dart:convert';
// import 'package:flutter/foundation.dart';
// import 'package:firebase_messaging/firebase_messaging.dart';
// import 'package:flutter_local_notifications/flutter_local_notifications.dart';
// import 'package:get/get.dart';
// import 'package:http/http.dart' as http;
// import 'package:logger/logger.dart';
// import 'package:yops/getx_controller/notification_getx_controller.dart';
//
// class NotificationApp {
//   final FirebaseMessaging messaging = FirebaseMessaging.instance;
//   final FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
//   FlutterLocalNotificationsPlugin();
//
//   String? fcmToken;
//
//   Future<String?> getFcmToken() async {
//     if (kIsWeb || (Platform.isIOS && !await _isRealDevice())) {
//       print("Skipping FCM token on web or iOS simulator");
//       return null;
//     }
//     fcmToken = await messaging.getToken();
//     print("FCM Token: $fcmToken");
//     return fcmToken;
//   }
//
//   Future<void> initNotification() async {
//     await getFcmToken();
//
//     if (fcmToken != null) {
//       await messaging.subscribeToTopic('all');
//       await Get.put(NotificationGetxController()).sendTokenToServer(fcmToken!); // إرسال التوكن للسيرفر مباشرة
//     }
//
//     await messaging.requestPermission(
//       alert: true,
//       badge: true,
//       sound: true,
//     );
//
//     const AndroidInitializationSettings androidSettings =
//     AndroidInitializationSettings('@mipmap/ic_launcher');
//     const DarwinInitializationSettings iosSettings = DarwinInitializationSettings();
//     const InitializationSettings initSettings = InitializationSettings(
//       android: androidSettings,
//       iOS: iosSettings,
//     );
//
//     await flutterLocalNotificationsPlugin.initialize(initSettings);
//
//     FirebaseMessaging.onMessage.listen((RemoteMessage message) {
//       if (message.notification != null) {
//         localNot(message.notification!.title ?? '', message.notification!.body ?? '');
//       }
//     });
//   }
//
//   Future<void> localNot(String title, String body) async {
//     const AndroidNotificationDetails androidDetails =
//     AndroidNotificationDetails('channel_id', 'channel_name', channelDescription: 'desc');
//     const DarwinNotificationDetails iosDetails = DarwinNotificationDetails();
//
//     const NotificationDetails platformDetails = NotificationDetails(
//       android: androidDetails,
//       iOS: iosDetails,
//     );
//
//     await flutterLocalNotificationsPlugin.show(0, title, body, platformDetails);
//   }
//
//   // Future<void> sendTokenToServer(String token) async {
//   //   final deviceType = Platform.isAndroid ? "android" : "ios";
//   //   final deviceId = "unique_device_id"; // يمكنك استبداله بأي ID فريد لجهاز المستخدم
//   //
//   //   final url = Uri.parse("{{base_url}}/user/fcm-token");
//   //
//   //   try {
//   //     final response = await http.post(
//   //       url,
//   //       headers: {
//   //         'Accept': 'application/json',
//   //         'Content-Type': 'application/json',
//   //         // أضف Authorization إذا كان مطلوبًا: 'Authorization': 'Bearer YOUR_TOKEN',
//   //       },
//   //       body: jsonEncode({
//   //         "token": token,
//   //         "device_type": deviceType,
//   //         "device_id": deviceId,
//   //       }),
//   //     );
//   //     Logger().d({
//   //       "token": token,
//   //       "device_type": deviceType,
//   //       "device_id": deviceId,
//   //     });
//   //
//   //     if (response.statusCode == 200 || response.statusCode == 201) {
//   //       print("FCM token sent successfully to server");
//   //     } else {
//   //       print("Failed to send FCM token: ${response.body}");
//   //     }
//   //   } catch (e) {
//   //     print("Error sending FCM token: $e");
//   //   }
//   // }
//
//   Future<bool> _isRealDevice() async {
//     return !Platform.isIOS ? true : false;
//   }
// }
