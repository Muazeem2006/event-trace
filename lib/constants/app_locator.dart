import 'dart:developer'; 

import 'package:geocoding/geocoding.dart';
import 'package:geolocator/geolocator.dart';

Future<String> getLocation() async {
  try {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error('Location services are disabled.');
    }

    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      permission = await Geolocator.requestPermission();
      if (permission == LocationPermission.denied) {
        return Future.error('Location permissions are denied');
      }
    }

    if (permission == LocationPermission.deniedForever) {
      return Future.error(
          'Location permissions are permanently denied, we cannot request permissions.');
    }

    Position position = await Geolocator.getCurrentPosition();

    log('Latitude: ${position.latitude}');
    log('Longitude: ${position.longitude}');

    List<Placemark> placemarks =
        await placemarkFromCoordinates(position.latitude, position.longitude);
    Placemark placemark = placemarks[0];
    // for (Placemark placemark in placemarks) {
    log('Placemark: ${placemark.toJson()}');
    return '${placemark.subLocality}, ${placemark.locality}, ${placemark.administrativeArea}, ${placemark.country}';
    // }
  } catch (e) {
    log('Error getting location: $e');
    return 'Unknown location';
  }
}
