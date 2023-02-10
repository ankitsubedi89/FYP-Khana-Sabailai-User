import 'package:geolocator/geolocator.dart';
import 'package:khana_sabailai_user/utils/utils.dart';

Future<bool> handleLocationPermission() async {
  bool serviceEnabled;
  LocationPermission permission;

  serviceEnabled = await Geolocator.isLocationServiceEnabled();
  if (!serviceEnabled) {
    customGetSnackbar('Service Disabled',
        'Location services are disabled. Please enable the services', 'error');
    return false;
  }
  permission = await Geolocator.checkPermission();
  if (permission == LocationPermission.denied) {
    permission = await Geolocator.requestPermission();
    if (permission == LocationPermission.denied) {
      customGetSnackbar(
          'Permission Denied', 'Location permissions are denied', 'error');
      return false;
    }
  }
  if (permission == LocationPermission.deniedForever) {
    customGetSnackbar(
        'Permission Denied Forever',
        'Location permissions are permanently denied, we cannot request permissions.',
        'error');
    return false;
  }
  return true;
}
