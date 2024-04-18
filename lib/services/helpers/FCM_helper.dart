import 'dart:developer';

import 'package:firebase_messaging/firebase_messaging.dart';

class FCMHelper {

  FCMHelper._();

  static final FCMHelper fcmHelper = FCMHelper._();

  FirebaseMessaging firebaseMessaging = FirebaseMessaging.instance;

  void notifications(){
    FirebaseMessaging.onMessage.listen((RemoteMessage message) {
      log("This is ${message.notification!.title}");
    });
  }

  Future<String?> getToken()async{
    String? deviceToken = await firebaseMessaging.getToken();
    log(deviceToken!);
    return null;
  }


}