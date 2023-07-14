import 'package:flutter/material.dart';
import 'package:lopes_weather/src/modules/home/domain/entities/forecast_day_weather_entity.dart';
import 'package:lopes_weather/src/modules/home/domain/usecases/get_forecast_day_weather_usecase/get_forecast_day_weather_usecase.dart';
import 'package:lopes_weather/src/modules/home/domain/usecases/get_location_weather_usecase/get_location_weather_usecase.dart';

import 'package:lopes_weather/src/shared/services/location_service.dart';

import 'package:weather/weather.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:latlong2/latlong.dart';
import 'package:geocoding/geocoding.dart';
import 'package:lat_lng_to_timezone/lat_lng_to_timezone.dart' as tzmap;
import 'package:timezone/standalone.dart' as tz;

class HomeCubit extends Cubit<HomeState> {
  final GetLocationWeatherUseCase getLocationWeatherUseCase;
  final GetForecastDayWeatherUsecase getForecastDayWeatherUsecase;
  HomeCubit(this.getLocationWeatherUseCase, this.getForecastDayWeatherUsecase)
      : super(HomeStateLoading());

  final LatLng defaultLocation = LatLng(48.864480, 2.352011);
  Weather? weather;
  List<ForecastDayWeatherEntity>? forecast = [];
  DateTime currentDateTime = DateTime.now();
  List<Color> backgroundColor = [Colors.blue, Colors.blue];
  String? areaName;

  Future<void> getLocationWeather({String? description}) async {
    emit(HomeStateLoading());
    try {
      final coordinates;
      if (description == null) {
        coordinates = await _getCurrentLocationData();
      } else {
        coordinates = await _getSearchedPlaceWeather(description);
      }
      weather = await getLocationWeatherUseCase(coordinates);
      forecast = await getForecastDayWeatherUsecase(coordinates);

      if (areaName!.isEmpty) {
        areaName = weather!.areaName;
      }
      _getDateTimeData(coordinates);
      emit(HomeStateSuccess());
    } catch (e) {
      emit(HomeStateError(e as Exception));
    }
  }

  Future<LatLng> _getSearchedPlaceWeather(String description) async {
    List<Location> locations = await locationFromAddress(description);
    areaName = description;
    return LatLng(locations.first.latitude, locations.first.longitude);
  }

  Future<LatLng> _getCurrentLocationData() async {
    final currentLocation = await LocationService.getCurrentLocation();
    final coordinates =
        LatLng(currentLocation.latitude, currentLocation.longitude);
    List<Placemark> placemarks = await placemarkFromCoordinates(
        currentLocation.latitude, currentLocation.longitude,
        localeIdentifier: 'pt');
    areaName = placemarks.first.subLocality;
    return coordinates;
  }

  void _getDateTimeData(LatLng location) {
    final timeZone =
        tzmap.latLngToTimezoneString(location.latitude, location.longitude);
    final country = tz.getLocation(timeZone);
    currentDateTime = tz.TZDateTime.now(country);
  }
}

abstract class HomeState {}

class HomeStateLoading extends HomeState {}

class HomeStateSuccess extends HomeState {}

class HomeStateError extends HomeState {
  final Exception error;
  HomeStateError(this.error);
}
