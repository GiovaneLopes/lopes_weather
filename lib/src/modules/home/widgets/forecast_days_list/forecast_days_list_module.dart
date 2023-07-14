import 'package:flutter_modular/flutter_modular.dart';
import 'package:lopes_weather/src/modules/home/widgets/forecast_days_list/forecast_days_list_cubit.dart';

class ForecastDaysListModule extends Module {
  @override
  List<Bind<Object>> get binds => [
    Bind.lazySingleton((i) => ForecastDaysListCubit())
  ];
}
