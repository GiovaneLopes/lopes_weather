import 'package:latlong2/latlong.dart';
import 'package:lopes_weather/src/modules/home/domain/entities/forecast_day_weather_entity.dart';
import 'package:lopes_weather/src/modules/home/domain/repositories/get_forecast_day_weather_repository/get_forecast_weather_repository.dart';
import 'package:lopes_weather/src/modules/home/domain/usecases/get_forecast_day_weather_usecase/get_forecast_day_weather_usecase.dart';

class GetForecastDayWeatherUsecaseImp implements GetForecastDayWeatherUsecase {
  final GetForecastDayWeatherRepository getForecastDayWeatherRepository;
  GetForecastDayWeatherUsecaseImp(this.getForecastDayWeatherRepository);
  @override
  Future<List<ForecastDayWeatherEntity>> call(LatLng coordinates) async {
    return await getForecastDayWeatherRepository(coordinates);
  }
}
