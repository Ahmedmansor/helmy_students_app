import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:helmy/AppRoot/app_root.dart';

import 'repos/dio_helper.dart';

void main() async {
  await DioHelper.init();
  await Future.delayed(const Duration(seconds: 2));
  FlutterNativeSplash.remove();
  runApp(const AppRoot());
}
