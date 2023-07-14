import 'package:latlong2/latlong.dart';
import 'package:lopes_weather/src/modules/home/domain/entities/forecast_day_weather_entity.dart';

abstract class GetForecastDayWeatherUsecase {
  Future<List<ForecastDayWeatherEntity>> call(LatLng coordinates);
}
