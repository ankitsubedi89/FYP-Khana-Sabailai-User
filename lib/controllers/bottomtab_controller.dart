import 'package:get/get.dart';
import 'package:khana_sabailai_user/screens/home/account_screen.dart';
import 'package:khana_sabailai_user/screens/home/cart_screen.dart';
import 'package:khana_sabailai_user/screens/home/home_screen.dart';
import 'package:khana_sabailai_user/screens/home/restaurant_screen.dart';

class BottomTabController extends GetxController {
  int currentIndex = 0;
  final List children = [
    const HomeScreen(),
    const RestaurantScreen(),
    const CartScreen(),
    const AccountScreen()
  ];

  void onTabTapped(int index) {
    currentIndex = index;
    update();
  }

  // @override
  // void onInit() {
  //   super.onInit();
  // }
}
