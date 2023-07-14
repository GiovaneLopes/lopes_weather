import 'package:latlong2/latlong.dart';

import 'package:lopes_weather/src/modules/home/domain/repositories/get_location_weather_repository/get_location_weather_repository.dart';
import 'package:lopes_weather/src/modules/home/domain/usecases/get_location_weather_usecase/get_location_weather_usecase.dart';
import 'package:weather/weather.dart';

class GetLocationWeatherUseCaseImp implements GetLocationWeatherUseCase {
  final GetLocationWeatherRepository getLocationWeatherRepository;
  GetLocationWeatherUseCaseImp(this.getLocationWeatherRepository);
  @override
  Future<Weather> call(LatLng coordinates) async {
    return await getLocationWeatherRepository(coordinates);
  }
}
