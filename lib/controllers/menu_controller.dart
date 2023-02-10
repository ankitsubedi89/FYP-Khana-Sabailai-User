import 'dart:convert';

import 'package:get/get.dart';
import 'package:khana_sabailai_user/baseurl.dart';
import 'package:khana_sabailai_user/models/category.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_user/models/menu.dart';

class MenuController extends GetxController {
  List<Category> categories = [];
  List<Menu> menu = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchAllCategories();
    fetchAllMenu();
  }

  fetchAllCategories() async {
    var url = Uri.parse('${baseurl}categories/getAllCategories.php');
    var res = await http.get(url);

    var response = await jsonDecode(res.body);

    if (response['success']) {
      categories = AllCategories.fromJson(response).category!;
    }

    update();
  }

  fetchAllMenu() async {
    var url = Uri.parse('${baseurl}menu/getAllMenu.php');
    var res = await http.get(url);

    var response = await jsonDecode(res.body);

    if (response['success']) {
      menu = AllMenus.fromJson(response).menu!;
    }

    update();
  }

  List<Menu> getFilteredMenu(catId, resId) {
    return menu
        .where((element) =>
            element.categoryId == catId && element.restaurantId == resId)
        .toList();
  }
}
