import 'package:flutter_modular/flutter_modular.dart';
import 'package:lopes_weather/src/modules/home/home_module.dart';
import 'package:lopes_weather/src/modules/home/submodules/search_place/search_place_module.dart';

class AppModdule extends Module {
  @override
  List<Bind<Object>> get binds => [];

  @override
  List<ModularRoute> get routes => [
        ModuleRoute('/', module: HomeModule()),
        ModuleRoute('/search-place', module: SearchPlaceModule()),
      ];
}
