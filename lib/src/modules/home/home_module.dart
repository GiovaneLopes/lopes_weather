import 'package:flutter_modular/flutter_modular.dart';
import 'package:lopes_weather/src/modules/home/data/datasources/get_location_weather_remote_data_source.dart';
import 'package:lopes_weather/src/modules/home/data/repositories/get_forecast_weather_repository_imp/get_forecast_weather_repository_imp.dart';
import 'package:lopes_weather/src/modules/home/data/repositories/get_location_weather_repository_imp/get_location_weather_repository_imp.dart';
import 'package:lopes_weather/src/modules/home/domain/usecases/get_forecast_day_weather_usecase/get_forecast_day_weather_usecase_imp.dart';
import 'package:lopes_weather/src/modules/home/domain/usecases/get_location_weather_usecase/get_location_weather_usecase_imp.dart';

import 'package:lopes_weather/src/modules/home/home_cubit.dart';
import 'package:lopes_weather/src/modules/home/home_page.dart';

class HomeModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => GetLocationWeatherRemoteDatasource()),
        Bind.lazySingleton((i) => GetLocationWeatherRepositoryImp(i())),
        Bind.lazySingleton((i) => GetLocationWeatherUseCaseImp(i())),
        Bind.lazySingleton((i) => GetForecastDayWeatherUsecaseImp(i())),
        Bind.lazySingleton((i) => GetForecastDayWeatherRepositoryImp(i())),
        Bind.lazySingleton((i) => HomeCubit(i(), i())),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute('/', child: (context, args) => const HomePage()),
      ];
}
