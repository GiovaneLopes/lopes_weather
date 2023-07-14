import 'package:geolocator/geolocator.dart';

import '../helpers/exception.dart';

class LocationService {
  static Future<Position> getCurrentLocation() async {
    bool serviceEnabled = await Geolocator.isLocationServiceEnabled();
    if (!serviceEnabled) {
      return Future.error(
        LocationNotEnabledException(
          message: 'Habilite a localização do dispositivo',
        ),
      );
    }
    await Geolocator.requestPermission();
    LocationPermission permission = await Geolocator.checkPermission();
    if (permission == LocationPermission.denied) {
      return Future.error(
        LocationNotAllowedException(
          message: 'Permissão de localização negada',
        ),
      );
    }
    if (permission == LocationPermission.deniedForever) {
      return Future.error(
        LocationNotAllowedException(
          message: 'Permissão de localização permanentemente negada',
        ),
      );
    }
    return await Geolocator.getCurrentPosition(
      desiredAccuracy: LocationAccuracy.best,
      forceAndroidLocationManager: true,
    );
  }
}
