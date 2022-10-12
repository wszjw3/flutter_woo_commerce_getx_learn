import 'package:flutter/material.dart';
import 'package:flutter_easyloading/flutter_easyloading.dart';
import 'package:flutter_screenutil/flutter_screenutil.dart';
import 'package:flutter_woo_commerce_getx_learn/common/index.dart';
import 'package:get/get.dart';

import 'common/routers/pages.dart';
import 'global.dart';

Future<void> main() async {
  await Global.init();
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return ScreenUtilInit(
      designSize: const Size(414, 896),
      splitScreenMode: false,
      minTextAdapt: false,
      builder: (context, child) {

        return GetMaterialApp(
          title: 'Flutter Demo',
          theme: ConfigService.to.isDarkModel ? AppTheme.dark : AppTheme.light,
          initialRoute: RouteNames.systemSplash,
          getPages: RoutePages.list,
          navigatorObservers: [RoutePages.observer],
          // 多语言
          translations: Translation(),
          // 词典
          localizationsDelegates: Translation.localizationsDelegates,
          // 代理
          supportedLocales: Translation.supportedLocales,
          // 支持的语言种类
          locale: ConfigService.to.locale,
          // 当前语言种类
          fallbackLocale: Translation.fallbackLocale, // 默认语言种类
          // builder
          builder: (context, widget) {
            widget = EasyLoading.init()(context, widget); // EasyLoading 初始化
            // 不随系统字体缩放比例
            return MediaQuery(
              data: MediaQuery.of(context).copyWith(textScaleFactor: 1.0),
              child: widget,
            );
          },

          debugShowCheckedModeBanner: false,
        );
      }
    );
  }
}
