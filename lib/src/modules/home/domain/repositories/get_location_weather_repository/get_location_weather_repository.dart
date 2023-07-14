import 'package:latlong2/latlong.dart';
import 'package:weather/weather.dart';

abstract class GetLocationWeatherRepository {
  Future<Weather> call(LatLng coordinates);
}
