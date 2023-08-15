import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/material.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter_local_notifications/flutter_local_notifications.dart';
import 'package:get/get.dart';
import 'package:get/get_core/src/get_main.dart';
import 'main_page.dart';

String token = '';

Future<void> _firebaseMessagingBackgroundHandler(RemoteMessage message) async {
  print('Handling a background message ${message.messageId}');
}

Future<void> _fbMsgForegroundHandler(
    RemoteMessage message,
    FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin,
    AndroidNotificationChannel? channel) async {
  print('[FCM - Foreground] MESSAGE : ${message.data}');

  if (message.notification != null) {
    print('Message also contained a notification: ${message.notification}');
    FlutterLocalNotificationsPlugin().show(
      message.hashCode,
      message.notification!.title,
      message.notification!.body,
      NotificationDetails(
        android: AndroidNotificationDetails(
          channel!.id,
          channel.name,
          channelDescription: channel.description,
          icon: '@mipmap/ic_launcher',
        ),
      ),
    );
  }
}

/**
 * FCM 메시지 클릭 이벤트 정의 
 */

Future<void> _setupInteractedMessage(FirebaseMessaging fbMsg) async {
  RemoteMessage? initialMessage = await fbMsg.getInitialMessage();

  // 종료 상태에서 클릭한 푸시 알림 메시지 핸들링
  if (initialMessage != null) _clickMessageEvent(initialMessage);

  FirebaseMessaging.onMessageOpenedApp.listen(_clickMessageEvent);
}

_clickMessageEvent(RemoteMessage message) {
  print('message : ${message.notification!.title}');
  Get.toNamed('/');
}

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();

  FirebaseMessaging fbMsg = FirebaseMessaging.instance;

  fbMsg.onTokenRefresh.listen((newToken) {
    print('onTokenRefresh : $newToken');
  });

  runApp(const MessagingExampleApp());

  // 플랫폼 확인 후 권한요청 및 flutter local notification plugin 설정
  FlutterLocalNotificationsPlugin flutterLocalNotificationsPlugin =
      FlutterLocalNotificationsPlugin();

  AndroidNotificationChannel? androidNotificationChannel;

  androidNotificationChannel = const AndroidNotificationChannel(
    'important_channel',
    'Important_Notifications',
    description: 'This channel is used for important notifications.',
    importance: Importance.high,
  );

  await flutterLocalNotificationsPlugin
      .resolvePlatformSpecificImplementation<
          AndroidFlutterLocalNotificationsPlugin>()
      ?.createNotificationChannel(androidNotificationChannel);

  //Background Message Handler
  FirebaseMessaging.onBackgroundMessage(_firebaseMessagingBackgroundHandler);

  //Foreground Message Handler
  FirebaseMessaging.onMessage.listen((RemoteMessage message) {
    _fbMsgForegroundHandler(
        message, flutterLocalNotificationsPlugin, androidNotificationChannel);
  });

  // 클릭 이벤트 정의
  await _setupInteractedMessage(fbMsg);
}

class MessagingExampleApp extends StatefulWidget {
  const MessagingExampleApp({super.key});

  @override
  State<MessagingExampleApp> createState() => _MessagingExampleAppState();
}

class _MessagingExampleAppState extends State<MessagingExampleApp> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        title: 'Firebase Messaging Demo',
        theme: ThemeData(
          fontFamily: 'Raleway',
          primarySwatch: Colors.blue,
        ),
        home: MainPage());
  }
}
