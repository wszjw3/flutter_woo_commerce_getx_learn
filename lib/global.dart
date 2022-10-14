import 'package:flutter/material.dart';
import 'package:flutter_native_splash/flutter_native_splash.dart';
import 'package:get/get.dart';

import 'common/index.dart';

class Global {
  static Future<void> init() async {
    var widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
    FlutterNativeSplash.preserve(widgetsBinding: widgetsBinding);
    // 工具类
    await Storage().init();
    Loading();

    // await Future.wait([
    //   Get.putAsync<ConfigService>(() async => await ConfigService().init()),
    // ]).whenComplete(() {
    // });
    Get.put<ConfigService>(ConfigService());
    Get.put<WPHttpService>(WPHttpService());
    Get.put<UserService>(UserService());
  }
}