import 'dart:convert';

import 'package:get/get.dart';
import 'package:khana_sabailai_user/baseurl.dart';
import 'package:khana_sabailai_user/models/order.dart';
import 'package:khana_sabailai_user/models/user.dart';
import 'package:khana_sabailai_user/utils/shared_prefs.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_user/utils/utils.dart';

class OrderController extends GetxController {
  List<Order> orders = [];
  bool isLoading = false;

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();
    fetchOrders();
  }

  fetchOrders() async {
    isLoading = true;
    update();
    var usr = await SharedPrefs().getUser();
    User user = User.fromJson(json.decode(usr));
    var url = Uri.parse('${baseurl}orders/getUserOrders.php');
    var res = await http.post(url, body: {'user_id': user.userId!});

    var response = await jsonDecode(res.body);

    if (response['success']) {
      orders = AllOrders.fromJson(response).order!;
    }
    isLoading = false;
    update();
  }

  changeOrderStatus(status, orderId) async {
    var url = Uri.parse('${baseurl}orders/changeOrderStatus.php');
    var res =
        await http.post(url, body: {'status': status, 'order_id': orderId});

    var response = await jsonDecode(res.body);

    if (response['success']) {
      fetchOrders();

      customGetSnackbar('Success', response['message'], 'success');
    } else {
      customGetSnackbar('Error', response['message'], 'error');
    }
  }

  List<Order> getTodayOrders(bool isToday) {
    if (!isToday) {
      return orders;
    }
    //convert orders date to dart format and compare to see if the order is from today
    return orders.where((element) {
      var date = DateTime.parse(element.date!);
      return date.day == DateTime.now().day &&
          date.month == DateTime.now().month &&
          date.year == DateTime.now().year;
    }).toList();
  }
}
