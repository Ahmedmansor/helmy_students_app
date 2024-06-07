import 'package:flutter/material.dart';
import 'package:helmy/core/utils/app_settings.dart';

import '../../core/utils/navigation.dart';
import '../auth/auth_view.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    super.initState();

    Future.delayed(Duration(seconds: 3), () {
      NavigationUtils.goToAndOff(context, const LoginScreen());
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Padding(
          padding: EdgeInsets.only(bottom: 20),
          child: Column(
            children: [
              Expanded(
                child: Center(
                  child: Image.asset(
                    'assets/images/10165937.jpg',
                    height: AppSettings.height * 0.5,
                    width: AppSettings.width,
                  ),
                ),
              ),
              Text.rich(
                TextSpan(
                  text: 'The Power Of ',
                  style: TextStyle(color: Colors.black),
                  children: [
                    TextSpan(
                      text: 'AI Technology',
                      style: TextStyle(
                          decoration: TextDecoration.underline,
                          color: Colors.blue[900]),
                    ),
                  ],
                ),
              ),
            ],
          )),
    );
  }
}
