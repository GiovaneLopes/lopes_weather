import 'package:lopes_weather/src/modules/home/data/datasources/get_location_weather_remote_data_source.dart';
import 'package:lopes_weather/src/modules/home/domain/entities/forecast_day_weather_entity.dart';
import 'package:latlong2/latlong.dart';
import 'package:lopes_weather/src/modules/home/domain/repositories/get_forecast_day_weather_repository/get_forecast_weather_repository.dart';

class GetForecastDayWeatherRepositoryImp
    implements GetForecastDayWeatherRepository {
  final GetLocationWeatherRemoteDatasource getLocationWeatherRemoteDatasource;
  GetForecastDayWeatherRepositoryImp(this.getLocationWeatherRemoteDatasource);
  @override
  Future<List<ForecastDayWeatherEntity>> call(LatLng coordinates) async {
    return await getLocationWeatherRemoteDatasource
        .getForecastList(coordinates);
  }
}
