import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_woo_commerce_getx_learn/common/index.dart';
import 'package:flutter_woo_commerce_getx_learn/pages/index.dart';
import 'package:get/get.dart';

import 'index.dart';
import 'widgets/navigation.dart';

class MainPage extends StatefulWidget {
  const MainPage({Key? key}) : super(key: key);

  @override
  _MainPageState createState() => _MainPageState();
}

class _MainPageState extends State<MainPage>
    with AutomaticKeepAliveClientMixin {
  @override
  bool get wantKeepAlive => true;

  @override
  Widget build(BuildContext context) {
    super.build(context);
    return const _MainViewGetX();
  }
}

class _MainViewGetX extends GetView<MainController> {
  const _MainViewGetX({Key? key}) : super(key: key);

  // 主视图
  // 主视图
  Widget _buildView() {
    DateTime? _lastPressedAt;
    return WillPopScope(
      // 防止连续点击两次退出
      onWillPop: () async {
        if (_lastPressedAt == null ||
            DateTime.now().difference(_lastPressedAt!) >
                const Duration(seconds: 1)) {
          _lastPressedAt = DateTime.now();
          Loading.toast('Press again to exit');
          return false;
        }
        await SystemChannels.platform.invokeMethod('SystemNavigator.pop');
        return true;
      },
      child: Scaffold(
        extendBody: true,
        resizeToAvoidBottomInset: false,
        // 导航栏
        bottomNavigationBar: GetBuilder<MainController>(
          id: 'navigation',
          builder: (controller) {
            return BuildNavigation(
              currentIndex: controller.currentIndex,
              items: [
                NavigationItemModel(
                  label: LocaleKeys.tabBarHome.tr,
                  icon: AssetsSvgs.navHomeSvg,
                ),
                NavigationItemModel(
                  label: LocaleKeys.tabBarCart.tr,
                  icon: AssetsSvgs.navCartSvg,
                  count: 3,
                ),
                NavigationItemModel(
                  label: LocaleKeys.tabBarMessage.tr,
                  icon: AssetsSvgs.navMessageSvg,
                  count: 9,
                ),
                NavigationItemModel(
                  label: LocaleKeys.tabBarProfile.tr,
                  icon: AssetsSvgs.navProfileSvg,
                ),
              ],
              onTap: controller.onJumpToPage, // 切换tab事件
            );
          },
        ),
        // 内容页
        body: PageView(
          physics: const NeverScrollableScrollPhysics(), // 不响应用户的滚动
          controller: controller.pageController,
          onPageChanged: controller.onIndexChanged,
          children: const [
            HomePage(),
            CartIndexPage(),
            MsgIndexPage(),
            MyIndexPage(),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<MainController>(
      init: Get.find<MainController>(),
      id: "main",
      builder: (_) => _buildView(),
      // builder: (_) {
      //   return Scaffold(
      //     appBar: AppBar(title: const Text("main")),
      //     body: SafeArea(
      //       child: _buildView(),
      //     ),
      //   );
      // },
    );
  }
}
