import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lopes_weather/src/modules/home/domain/entities/forecast_day_weather_entity.dart';
import 'package:lopes_weather/src/shared/helpers/date_helper.dart';
import 'package:quiver/iterables.dart';
import 'package:weather/weather.dart';
import 'package:latlong2/latlong.dart';

class GetLocationWeatherRemoteDatasource {
  late final WeatherFactory wf;
  GetLocationWeatherRemoteDatasource() {
    init();
  }

  void init() {
    wf = WeatherFactory(
      dotenv.env['WEATHER_API_KEY']!,
      language: Language.PORTUGUESE_BRAZIL,
    );
  }

  Future<Weather> getLocationWeather(LatLng latLng) async {
    try {
      final Weather weather =
          await wf.currentWeatherByLocation(latLng.latitude, latLng.longitude);

      return weather;
    } catch (e) {
      throw Exception();
    }
  }

  Future<List<ForecastDayWeatherEntity>> getForecastList(LatLng latLng) async {
    try {
      final allForecasts =
          await wf.fiveDayForecastByLocation(latLng.latitude, latLng.longitude);
      final forecastDaysList = _getForecastDaysFromWeatherList(allForecasts);
      return forecastDaysList;
    } catch (e) {
      throw Exception();
    }
  }

  List<ForecastDayWeatherEntity> _getForecastDaysFromWeatherList(
      List<Weather> allForecasts) {
    var separatedWeatherDays = partition(allForecasts, 8);

    final forecastList = separatedWeatherDays.map((list) {
      ForecastDayWeatherEntity forecastDayWeatherEntity =
          ForecastDayWeatherEntity(
        list.first.date!,
        DateHelper().getAbbreviatedWeekDayName(list.first.date!.weekday + 1),
        list.first.tempMax!.celsius!.toInt(),
        list.first.tempMin!.celsius!.toInt(),
        list.first.weatherIcon!,
      );
      list.map((weather) {
        if (weather.tempMax!.celsius! > forecastDayWeatherEntity.tempMax) {
          forecastDayWeatherEntity = forecastDayWeatherEntity.copyWith(
            tempMax: weather.tempMax!.celsius!.toInt(),
            iconUrl: weather.weatherIcon,
          );
        }
        if (weather.tempMin!.celsius! < forecastDayWeatherEntity.tempMin) {
          forecastDayWeatherEntity = forecastDayWeatherEntity.copyWith(
              tempMin: weather.tempMin!.celsius!.toInt());
        }
      }).toList();
      return forecastDayWeatherEntity;
    }).toList();
    return forecastList;
  }
}
