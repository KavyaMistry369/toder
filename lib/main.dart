import 'package:firebase_core/firebase_core.dart';
import 'package:firebase_messaging/firebase_messaging.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:toder/controllers/controller_one.dart';
import 'package:toder/services/helpers/FCM_helper.dart';
import 'package:toder/services/helpers/notifications_helper.dart';
import 'package:toder/utils/routes.dart';
import 'package:toder/views/screens/add_page.dart';
import 'package:toder/views/screens/home_page.dart';
import 'package:toder/views/screens/login_page.dart';
import 'package:toder/views/screens/register_page.dart';
import 'package:toder/views/screens/splash_page.dart';
import 'package:toder/views/screens/update_page.dart';
import 'firebase_options.dart';
import 'package:timezone/data/latest.dart' as tz;

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp(
    options: DefaultFirebaseOptions.currentPlatform,
  );
  await FirebaseMessaging.instance.requestPermission();
  runApp(MultiProvider(
    providers: [
      ChangeNotifierProvider(
        create: (context) => ControllerOne(),
      )
    ],
    child: const MyApp(),
  ));
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      darkTheme: ThemeData(
        useMaterial3: true,
        colorSchemeSeed: CupertinoColors.activeBlue,
      ),
      theme: ThemeData(
        useMaterial3: true,
        brightness: Provider.of<ControllerOne>(context).isDark
            ? Brightness.dark
            : Brightness.light,
        colorSchemeSeed: CupertinoColors.activeBlue,
      ),
      routes: {
        '/': (context) => const SplashPage(),
        MyRoutes.login: (context) => const LoginPage(),
        MyRoutes.register: (context) => const RegisterPage(),
        MyRoutes.home: (context) => const HomePage(),
        MyRoutes.update: (context) => const UpdatePage(),
        MyRoutes.add: (context) => const AddPage(),
      },
    );
  }
}
