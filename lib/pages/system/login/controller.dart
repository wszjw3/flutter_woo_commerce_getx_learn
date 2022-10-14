import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce_getx_learn/common/index.dart';
import 'package:get/get.dart';

class LoginController extends GetxController {
  LoginController();
  /// 表单 key
  GlobalKey formKey = GlobalKey<FormState>();
  /// 定义输入控制器
  TextEditingController userNameController =
  TextEditingController(text: "ducafecat5");
  TextEditingController passwordController =
  TextEditingController(text: "123456");

  _initData() {
    update(["login"]);
  }

  /// Sign In
  Future<void> onSignIn() async {
    if ((formKey.currentState as FormState).validate()) {
      try {
        Loading.show();

        // api 请求
        UserTokenModel res = await UserApi.login(UserLoginReq(
          username: userNameController.text,
          password: passwordController.text,
        ));

        // 本地保存 token
        await UserService.to.setToken(res.token!);
        // 获取用户资料
        await UserService.to.getProfile();

        Loading.success();
        Get.back(result: true);
      } finally {
        Loading.dismiss();
      }
    }
  }

  /// Sign Up
  void onSignUp() {
    Get.offNamed(RouteNames.systemRegister);
  }

  void onTap() {}

  // @override
  // void onInit() {
  //   super.onInit();
  // }

  @override
  void onReady() {
    super.onReady();
    _initData();
  }

  // @override
  // void onClose() {
  //   super.onClose();
  // }

  /// 释放
  @override
  void onClose() {
    super.onClose();
    userNameController.dispose();
    passwordController.dispose();
  }
}
