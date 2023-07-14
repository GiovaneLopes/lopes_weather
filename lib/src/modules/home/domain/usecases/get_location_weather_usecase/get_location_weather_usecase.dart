import 'package:latlong2/latlong.dart';
import 'package:weather/weather.dart';

abstract class GetLocationWeatherUseCase {
  Future<Weather> call(LatLng coordinates);
}
