import 'package:flutter_modular/flutter_modular.dart';
import 'package:lopes_weather/src/modules/home/submodules/search_place/search_place_cubit.dart';
import 'package:lopes_weather/src/modules/home/submodules/search_place/search_place_page.dart';

class SearchPlaceModule extends Module {
  @override
  List<Bind<Object>> get binds => [
        Bind.lazySingleton((i) => SearchPlaceCubit()),
      ];

  @override
  List<ModularRoute> get routes => [
        ChildRoute(
          '/',
          child: (context, args) => const SearchPlacePage(),
          transition: TransitionType.fadeIn,
        ),
      ];
}
