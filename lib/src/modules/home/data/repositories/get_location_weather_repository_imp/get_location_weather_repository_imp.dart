import 'package:latlong2/latlong.dart';
import 'package:weather/weather.dart';

import 'package:lopes_weather/src/modules/home/data/datasources/get_location_weather_remote_data_source.dart';
import 'package:lopes_weather/src/modules/home/domain/repositories/get_location_weather_repository/get_location_weather_repository.dart';

class GetLocationWeatherRepositoryImp implements GetLocationWeatherRepository {
  final GetLocationWeatherRemoteDatasource getLocationWeatherRemoteDatasource;
  GetLocationWeatherRepositoryImp(this.getLocationWeatherRemoteDatasource);
  @override
  Future<Weather> call(LatLng coordinates) async {
    return await getLocationWeatherRemoteDatasource
        .getLocationWeather(coordinates);
  }
}
