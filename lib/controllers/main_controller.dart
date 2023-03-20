import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khana_sabailai_user/baseurl.dart';
import 'package:khana_sabailai_user/models/restaurant.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_user/utils/utils.dart';

class MainController extends GetxController {
  String currentAddress = '';
  Rx<Position?> currentPosition = Rx<Position?>(null);
  var distance = -1.obs;

  var isLoading = false.obs;

  List<Restaurant> allRestaurants = [];
  List<Restaurant> filteredRestaurants = [];
  List<Restaurant> nearRestaurants = [];

  @override
  void onInit() {
    // TODO: implement onInit
    super.onInit();

    getCurrentPosition();
    fetchAllRestaurants();
  }

  Future<void> getCurrentPosition() async {
    isLoading.value = true;
    // await handleGeoPermissions();
    await Geolocator.getCurrentPosition(
            desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition.value = position;
      getAddressFromLatLng(position);
      fetchNearRestaurants(position);
    }).catchError((e) {});
    isLoading.value = false;
  }


  Future<void> getAddressFromLatLng(Position position) async {
    isLoading.value = true;
    List<Placemark> placemarks = await placemarkFromCoordinates(
        position.latitude, position.longitude);
    Placemark place = placemarks[0];
    currentAddress = '${place.locality}, ${place.administrativeArea}';
    isLoading.value = false;
    update();
  }

  search(String val) {
    if (val.isNotEmpty) {
      filteredRestaurants = allRestaurants
          .where((res) =>
              res.name!.toLowerCase().contains(val.toLowerCase()) ||
              res.address!.toLowerCase().contains(val.toLowerCase()))
          .toList();
    } else {
      filteredRestaurants = allRestaurants;
    }
    update();
  }
 

  fetchAllRestaurants() async {
    isLoading.value = true;
    update();
    var response = await http
        .get(Uri.parse('${baseurl}restaurants/getAllRestaurants.php'));
    var res = json.decode(response.body);
    if (res['success']) {
      allRestaurants = AllRestaurants.fromJson(res).restaurant!;
      filteredRestaurants = AllRestaurants.fromJson(res).restaurant!;
    } else {
      customGetSnackbar('Restaurant Fetch Failed', res['message'], 'error');
    }
    isLoading.value = false;
    update();
  }

  fetchNearRestaurants(Position position) async {
    isLoading.value = true;
    update();
    var response = await http
        .post(Uri.parse('${baseurl}restaurants/nearRestaurants.php'), body: {
      'lat': position.latitude.toString(),
      'lon': position.longitude.toString(),
      'distance': '5'
    });
    var res = json.decode(response.body);
    if (res['success']) {
      nearRestaurants = AllRestaurants.fromJson(res).restaurant!;
    }
    isLoading.value = false;
    update();
  }
}
