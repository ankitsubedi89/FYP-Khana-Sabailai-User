import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:get/get.dart';
import 'package:khana_sabailai_user/controllers/bottomtab_controller.dart';
import 'package:khana_sabailai_user/controllers/cart_controller.dart';
import 'package:khana_sabailai_user/controllers/main_controller.dart';
import 'package:khana_sabailai_user/controllers/menu_controller.dart';
import 'package:khana_sabailai_user/controllers/order_controller.dart';
import 'package:khana_sabailai_user/controllers/user_controller.dart';
import 'package:khana_sabailai_user/widgets/icon_with_badge.dart';

class BottomTab extends StatelessWidget {
  BottomTab({Key? key}) : super(key: key);

  final mainController = Get.put(MainController());
  final userController = Get.put(UserController());
  final orderController = Get.put(OrderController());
  final bottomTabController = Get.put(BottomTabController());
  final menuController = Get.put(MenuController());
  final cartController = Get.put(CartController());

  @override
  Widget build(BuildContext context) {
    return GetBuilder<BottomTabController>(builder: (controller) {
      return Scaffold(
        body: controller.children[controller.currentIndex],
        bottomNavigationBar: BottomNavigationBar(
          onTap: controller.onTabTapped,
          currentIndex: controller.currentIndex,
          type: BottomNavigationBarType.fixed,
          selectedItemColor: Colors.red,
          selectedLabelStyle:
              const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          unselectedLabelStyle:
              const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          items: [
            const BottomNavigationBarItem(
              icon: FaIcon(
                FontAwesomeIcons.house,
                size: 20,
              ),
              label: 'Home',
            ),
            const BottomNavigationBarItem(
              icon: IconWithBadge(
                icon: FaIcon(
                  FontAwesomeIcons.utensils,
                  size: 20,
                ),
              ),
              label: 'Restaurant',
            ),
            BottomNavigationBarItem(
              icon: GetBuilder<CartController>(builder: (controller) {
                return IconWithBadge(
                  label: controller.cartList.length,
                  icon: const FaIcon(
                    FontAwesomeIcons.cartShopping,
                    size: 20,
                  ),
                );
              }),
              label: 'Cart',
            ),
            const BottomNavigationBarItem(
              // icon: IconWithBadge(
              //   icon: FaIcon(
              //     FontAwesomeIcons.accusoft,
              //     size: 20,
              //   ),
                icon: Icon(
                  Icons.account_circle,
                  size: 20,
                ),
              label: 'Account',
            ),
          ],
        ),
      );
    });
  }
}
