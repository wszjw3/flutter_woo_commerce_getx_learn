import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_woo_commerce_getx_learn/common/index.dart';
import 'package:get/get.dart';

class SearchIndexController extends GetxController {
  SearchIndexController();

  // 搜索控制器
  final TextEditingController searchEditController = TextEditingController();
  // 搜索关键词
  final searchKeyWord = "".obs;
  // Tags 列表
  List<TagsModel> tagsList = [];

  // 搜索栏位 - 防抖
  void searchDebounce() {
    // getx 内置防抖处理
    debounce(
      // obs 对象
      searchKeyWord,

      // 回调函数
          (value) async {
        // 调试
        if (kDebugMode) {
          print("debounce -> " + value.toString());
        }

        // 拉取数据
        await _loadSearch(value as String);
        update(["search_index"]);
      },

      // 延迟 500 毫秒
      time: const Duration(milliseconds: 500),
    );

    // 监听搜索框变化
    searchEditController.addListener(() {
      searchKeyWord.value = searchEditController.text;
    });
  }

  /// 拉取数据
  Future<bool> _loadSearch(String keyword) async {
    if (keyword.trim().isEmpty == true) {
      tagsList.clear();
      return tagsList.isEmpty;
    }

    // 拉取数据
    var result = await ProductApi.tags(TagsReq(
      // 关键词
      search: keyword,
    ));

    // 清空数据
    tagsList.clear();

    // 返回数据不为空
    if (result.isNotEmpty) {
      tagsList.addAll(result); // 添加数据
    }

    return tagsList.isEmpty;
  }

  // 列表项点击事件
  void onListItemTap(TagsModel model) {
    // 跳转到商品详情页
    Get.toNamed(
      RouteNames.searchSearchFilter,
      arguments: {
        "tagId": model.id,
      },
    );
  }

  _initData() {
    update(["search_index"]);
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
    searchDebounce();
  }

  @override
  void onClose() {
    super.onClose();
    // 搜索控制器释放
    searchEditController.dispose();
  }

  // @override
  // void dispose() {
  //   super.dispose();
  // }
}
