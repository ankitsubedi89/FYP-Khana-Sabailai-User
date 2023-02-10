import 'dart:convert';

import 'package:geocoding/geocoding.dart';
import 'package:get/get.dart';
import 'package:geolocator/geolocator.dart';
import 'package:khana_sabailai_user/baseurl.dart';
import 'package:khana_sabailai_user/models/restaurant.dart';
import 'package:khana_sabailai_user/utils/handle_geo_permissions.dart';
import 'package:http/http.dart' as http;
import 'package:khana_sabailai_user/utils/utils.dart';

class MainController extends GetxController {
  String currentAddress = '';
  Position? currentPosition;

  bool isLoading = false;

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
    final hasPermission = await handleLocationPermission();

    if (!hasPermission) return;
    await Geolocator.getCurrentPosition(desiredAccuracy: LocationAccuracy.high)
        .then((Position position) {
      currentPosition = position;

      print(currentPosition);
      getAddressFromLatLng(position);
      fetchNearRestaurants(position);
      update();
    }).catchError((e) {});
  }

  Future<void> getAddressFromLatLng(Position position) async {
    await placemarkFromCoordinates(
            currentPosition!.latitude, currentPosition!.longitude)
        .then((List<Placemark> placemarks) {
      Placemark place = placemarks[0];

      currentAddress =
          '${place.street}, ${place.subLocality}, ${place.subAdministrativeArea}, ${place.postalCode}';
      update();
    }).catchError((e) {});
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
    isLoading = true;
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
    isLoading = false;
    update();
  }

  fetchNearRestaurants(Position position) async {
    isLoading = true;
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
    isLoading = false;
    update();
  }
}
