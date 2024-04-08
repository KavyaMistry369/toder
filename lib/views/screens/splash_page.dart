import 'dart:async';

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

import '../../utils/routes.dart';

class SplashPage extends StatefulWidget {
  const SplashPage({super.key});

  @override
  State<SplashPage> createState() => _SplashPageState();
}

class _SplashPageState extends State<SplashPage> {

  myTimer() {
    Timer.periodic(const Duration(seconds: 5), (timer) {
      Navigator.of(context).pushReplacementNamed(MyRoutes.login);
    });
  }

  @override
  void initState() {
    super.initState();
    myTimer();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Padding(
        padding: const EdgeInsets.all(16),
        child: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Image.asset(
                "lib/views/assets/logo.png",
                width: 150,
              ),
              const SizedBox(
                width: 30,
              ),
              const SizedBox(
                height: 30,
              ),
              const Text(
                "Toder",
                style: TextStyle(fontSize: 35,fontWeight: FontWeight.w500),
              ),
              const SizedBox(height: 50,),
              const LinearProgressIndicator(
                backgroundColor: CupertinoColors.activeBlue,
                color: Colors.white,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
