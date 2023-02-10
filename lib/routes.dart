import 'package:get/get.dart';
import 'package:khana_sabailai_user/screens/auth/login_screen.dart';
import 'package:khana_sabailai_user/screens/auth/signup_screen.dart';
import 'package:khana_sabailai_user/screens/food/category_screen.dart';
import 'package:khana_sabailai_user/screens/food/single_food_screen.dart';
import 'package:khana_sabailai_user/screens/home/bottom_tab.dart';
import 'package:khana_sabailai_user/screens/orders/orders_screen.dart';
import 'package:khana_sabailai_user/screens/restaurant/single_restaurant.dart';
import 'package:khana_sabailai_user/splash.dart';

class GetRoutes {
  static const String splash = '/splash';
  static const String login = '/login';
  static const String signup = '/signup';
  static const String bottomTab = '/bottomTab';
  static const String singleRestaurant = '/single-restaurant';
  static const String categoryScreen = '/category-screen';
  static const String singleFood = '/single-food';
  static const String orderScreen = '/orders-screen';

  static List<GetPage> routes = [
    GetPage(
      name: GetRoutes.splash,
      page: () => SplashScreen(),
    ),
    GetPage(
      name: GetRoutes.login,
      page: () => const LoginScreen(),
    ),
    GetPage(
      name: GetRoutes.signup,
      page: () => const SignupScreen(),
    ),
    GetPage(
      name: GetRoutes.bottomTab,
      page: () => BottomTab(),
    ),
    GetPage(
      name: GetRoutes.singleRestaurant,
      page: () => SingleRestaurant(),
    ),
    GetPage(
      name: GetRoutes.categoryScreen,
      page: () => CategoryScreen(),
    ),
    GetPage(
      name: GetRoutes.singleFood,
      page: () => SingleFoodScreen(),
    ),
    GetPage(
      name: GetRoutes.orderScreen,
      page: () => const OrdersScreen(),
    ),
  ];
}
