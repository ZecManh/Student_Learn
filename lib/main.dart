
import 'package:awesome_notifications/awesome_notifications.dart';
import 'package:camera/camera.dart';
import 'package:datn/firebase_options.dart';
import 'package:datn/notification/notification_controller.dart';
import 'package:datn/screen/face_recognition/camera_page.dart';
import 'package:datn/screen/tlu_tutor.dart';
import 'package:datn/utils/local_db.dart';
import 'package:firebase_app_check/firebase_app_check.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:hive_flutter/adapters.dart';

Future main() async {
  WidgetsFlutterBinding.ensureInitialized();

  cameras = await availableCameras();
  await Hive.initFlutter();
  await HiveBoxes.initialize();

  await AwesomeNotifications().initialize(
    null,
    [
      NotificationChannel(channelGroupKey: "basic_channel_group",
          channelKey: NotificationController.BASIC_CHANNEL_KEY, channelName: "Basic Channel", channelDescription: "Basic Notification",importance:NotificationImportance.High ),
      NotificationChannel(channelGroupKey: "subject_channel_group",
          channelKey: NotificationController.SUBJECT_REQUEST_CHANNEL_KEY, channelName: "Subject Request Channel", channelDescription: "Subject Request Notification",importance:NotificationImportance.High)
    ],
    channelGroups:[
      NotificationChannelGroup(channelGroupKey: "basic_channel_group", channelGroupName: "Basic Group"),
      NotificationChannelGroup(channelGroupKey: "subject_channel_group", channelGroupName: "Subject Group"),
    ]
  );
  bool isAllowedToSendNotification = await AwesomeNotifications().isNotificationAllowed();
  if(!isAllowedToSendNotification){
    AwesomeNotifications().requestPermissionToSendNotifications();
  }
  await Firebase.initializeApp(options: DefaultFirebaseOptions.currentPlatform);
  await FirebaseAppCheck.instance.activate(
    androidProvider: AndroidProvider.debug,
    appleProvider: AppleProvider.debug,
    webProvider:ReCaptchaV3Provider('recapcha-v3-site-key')
  );
  SystemChrome.setPreferredOrientations([DeviceOrientation.portraitUp])
      .then((value) {
    runApp(const TluTutor());
  });
}
