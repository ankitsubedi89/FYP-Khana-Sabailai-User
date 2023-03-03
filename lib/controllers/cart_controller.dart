import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/baseurl.dart';
import 'package:khana_sabailai_user/controllers/bottomtab_controller.dart';
import 'package:khana_sabailai_user/controllers/order_controller.dart';
import 'package:khana_sabailai_user/models/cart.dart';
import 'package:khana_sabailai_user/models/menu.dart';
import 'package:khana_sabailai_user/models/user.dart';
import 'package:khana_sabailai_user/routes.dart';
import 'package:khana_sabailai_user/utils/shared_prefs.dart';
import 'package:khana_sabailai_user/utils/utils.dart';
import 'package:http/http.dart' as http;

class CartController extends GetxController {
  bool isLoading = false;
  int foodQuantity = 1;
  List<CartType> cartList = [];

  TextEditingController specialRequestController = TextEditingController();

  updateFoodQuantity(int quantity) {
    foodQuantity = quantity;
    update();
  }

  addToCart(Menu menu, int quantity) {
    //check if the item is from same restaurant
    if (cartList.isNotEmpty) {
      if (cartList[0].menu.restaurantId != menu.restaurantId) {
        customGetSnackbar(
            'Error', 'You can only order from one restaurant', 'error');
        return;
      }
    }

    for (var element in cartList) {
      if (element.menu.id == menu.id) {
        element.quantity = quantity;
        Get.back();
        customGetSnackbar('Success', 'Successfully added to cart', 'success');
        foodQuantity = 1;
        update();
        return;
      }
    }

    cartList.add(CartType(menu: menu, quantity: quantity));
    Get.back();
    customGetSnackbar('Success', 'Successfully added to cart', 'success');
    foodQuantity = 1;
    update();
  }

  updateCart(Menu menu, int quantity) {
    for (var element in cartList) {
      if (element.menu.id == menu.id) {
        element.quantity = quantity;
      }
    }
    update();
  }

  removeFromCart(Menu menu) {
    cartList.removeWhere((element) => element.menu.id == menu.id);
    update();
  }

  getTotalPriceFromCartItems() {
    double totalPrice = 0;
    for (var element in cartList) {
      totalPrice += int.parse(element.menu.price!) * element.quantity;
    }
    return totalPrice;
  }

  makeOrder() async {
    isLoading = true;
    update();

    var orderList = cartList.map((e) {
      return {
        'id': e.menu.id,
        'quantity': e.quantity,
        'line_total': int.parse(e.menu.price!) * e.quantity,
      };
    }).toList();

    String restaurantId = cartList[0].menu.restaurantId!;

    try {
      var usr = await SharedPrefs().getUser();
      User user = User.fromJson(json.decode(usr));

      var url = Uri.parse('${baseurl}orders/addOrder.php');
      var response = await http.post(url, body: {
        'user_id': user.userId,
        'restaurant_id': restaurantId,
        'total_price': getTotalPriceFromCartItems().toString(),
        'special_request': specialRequestController.text,
        'orders': jsonEncode(orderList),
      });

      var res = await jsonDecode(response.body);

      if (res['success']) {
        cartList = [];
        specialRequestController.clear();
        final mainController = Get.find<BottomTabController>();
        mainController.currentIndex = 3;
        mainController.update();

        final orderController = Get.find<OrderController>();
        orderController.fetchOrders();
        orderController.update();

        Get.toNamed(GetRoutes.orderScreen);

        // final orderController = Get.find<OrderController>();
        // orderController.getOrders();
        // orderController.update();
        customGetSnackbar('Success', 'Order placed successfully', 'success');
      } else {
        customGetSnackbar('Error', 'Something went wrong here', 'error');
      }
    } catch (e) {
      customGetSnackbar('Error', 'Something went wrong', 'error');
    }

    isLoading = false;
    update();
  }
}
