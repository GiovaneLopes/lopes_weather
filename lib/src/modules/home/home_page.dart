import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:geolocator/geolocator.dart';
import 'package:intl/intl.dart';
import 'package:lopes_weather/src/modules/home/home_cubit.dart';
import 'package:lopes_weather/src/modules/home/widgets/forecast_days_list/forecast_days_list_widget.dart';
import 'package:lopes_weather/src/modules/home/widgets/home_skeleton_loading/home_skeleton_loading.dart';
import 'package:lopes_weather/src/shared/helpers/date_helper.dart';
import 'package:lopes_weather/src/shared/helpers/exception.dart';
import 'package:lopes_weather/src/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  late final TextEditingController _localController;
  final cubit = Modular.get<HomeCubit>();
  var format = DateFormat('dd/MM/yyyy - HH:mm');
  @override
  void initState() {
    super.initState();
    _localController = TextEditingController();
    cubit.getLocationWeather();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints(maxWidth: 600),
          child: SafeArea(
            child: Padding(
              padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
              child: Column(
                mainAxisAlignment: MainAxisAlignment.start,
                children: [
                  GestureDetector(
                    onTap: () => Modular.to.pushNamed('/search-place/'),
                    child: AbsorbPointer(
                      child: CustomTextFormField(
                        controller: _localController,
                        suffixIcon: Icons.search,
                        prefixIcon: Icons.location_on_outlined,
                        color: Colors.black,
                        readOnly: true,
                      ),
                    ),
                  ),
                  Expanded(
                    child: BlocConsumer(
                      bloc: cubit,
                      listener: (context, state) {
                        if (state is HomeStateError) {
                          final snackbar = SnackBar(
                            padding: const EdgeInsets.all(8),
                            backgroundColor: Colors.transparent,
                            elevation: 0,
                            content: Container(
                              width: double.infinity,
                              height: 60,
                              padding: const EdgeInsets.symmetric(
                                  vertical: 4, horizontal: 18),
                              decoration: BoxDecoration(
                                color: Colors.black,
                                borderRadius: BorderRadius.circular(8),
                              ),
                              child: Row(
                                mainAxisAlignment:
                                    MainAxisAlignment.spaceBetween,
                                children: [
                                  Text(
                                    state.error.runtimeType ==
                                            LocationNotEnabledException
                                        ? ' Habilite a localização do dispositivo'
                                        : 'Permissão de localização negada',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 16,
                                    ),
                                  ),
                                  GestureDetector(
                                    onTap: () async {
                                      if (state.error
                                          is LocationNotEnabledException) {
                                        await Geolocator.openLocationSettings();
                                      }
                                      if (state.error
                                          is LocationNotAllowedException) {
                                        await Geolocator.openAppSettings();
                                      }
                                    },
                                    child: const Icon(
                                      Icons.settings,
                                      color: Colors.white,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        }
                        setState(() {});
                      },
                      builder: (context, state) {
                        if (state is HomeStateLoading) {
                          return const HomeSkeletonLoading();
                        }
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 750,
                            ),
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Column(
                                  children: [
                                    AutoSizeText(
                                      '${format.format(cubit.currentDateTime)}, ${DateHelper().getFullWeekDayName(cubit.weather?.date?.weekday ?? 1)}',
                                      style: const TextStyle(
                                        fontSize: 18,
                                        color: Colors.black,
                                      ),
                                      maxLines: 1,
                                      minFontSize: 18,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    AutoSizeText(
                                      cubit.areaName?.toUpperCase() ?? '-',
                                      style: const TextStyle(
                                        fontSize: 32,
                                        color: Colors.black,
                                        fontWeight: FontWeight.w900,
                                      ),
                                      minFontSize: 22,
                                      maxLines: 1,
                                      overflow: TextOverflow.ellipsis,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    AutoSizeText(
                                      cubit.weather?.weatherDescription
                                              ?.toUpperCase() ??
                                          'Weather',
                                      style: const TextStyle(
                                        fontSize: 20,
                                        color: Colors.black,
                                        fontWeight: FontWeight.normal,
                                      ),
                                      textAlign: TextAlign.center,
                                      maxLines: 2,
                                      minFontSize: 20,
                                    ),
                                    const SizedBox(
                                      height: 12,
                                    ),
                                    Container(
                                      padding: const EdgeInsets.all(6),
                                      height: 150,
                                      width: 150,
                                      decoration: BoxDecoration(
                                        color: Colors.black.withOpacity(.1),
                                        borderRadius:
                                            BorderRadius.circular(100),
                                      ),
                                      child: CachedNetworkImage(
                                        imageUrl:
                                            'https://openweathermap.org/img/wn/${cubit.weather?.weatherIcon ?? '03d'}@2x.png',
                                        placeholder: ((context, url) =>
                                            const Center(
                                              child: CircularProgressIndicator(
                                                color: Colors.black,
                                              ),
                                            )),
                                        errorWidget: (context, url, error) =>
                                            const Icon(Icons.close),
                                        fit: BoxFit.cover,
                                      ),
                                    ),
                                  ],
                                ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.center,
                                  children: [
                                    Column(
                                      crossAxisAlignment:
                                          CrossAxisAlignment.center,
                                      children: [
                                        Row(
                                          mainAxisAlignment:
                                              MainAxisAlignment.center,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.start,
                                          children: [
                                            Text(
                                              cubit.weather?.temperature
                                                      ?.celsius
                                                      ?.round()
                                                      .toString() ??
                                                  '--',
                                              style: const TextStyle(
                                                fontSize: 100,
                                                color: Colors.black,
                                                fontWeight: FontWeight.w200,
                                              ),
                                            ),
                                            const Padding(
                                              padding:
                                                  EdgeInsets.only(top: 18.0),
                                              child: Text(
                                                '°',
                                                style: TextStyle(
                                                  fontSize: 50,
                                                  color: Colors.black,
                                                  fontWeight: FontWeight.w200,
                                                ),
                                              ),
                                            ),
                                          ],
                                        ),
                                        IntrinsicHeight(
                                          child: Row(
                                            mainAxisAlignment:
                                                MainAxisAlignment.center,
                                            children: [
                                              Column(
                                                children: [
                                                  const Text(
                                                    'max',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Text(
                                                    ' ${cubit.weather?.tempMax?.celsius?.round().toString() ?? '--'}°',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                              const VerticalDivider(
                                                color: Colors.grey,
                                              ),
                                              Column(
                                                children: [
                                                  const Text(
                                                    'min',
                                                    style: TextStyle(
                                                        fontSize: 16,
                                                        color: Colors.grey,
                                                        fontWeight:
                                                            FontWeight.w300),
                                                  ),
                                                  Text(
                                                    '${cubit.weather?.tempMin?.celsius?.round().toString() ?? '--'}°',
                                                    style: const TextStyle(
                                                      fontSize: 20,
                                                      color: Colors.black,
                                                      fontWeight:
                                                          FontWeight.w400,
                                                    ),
                                                  ),
                                                ],
                                              ),
                                            ],
                                          ),
                                        ),
                                      ],
                                    ),
                                    const SizedBox(
                                      height: 48,
                                    ),
                                    const ForecastDaysListWidget()
                                  ],
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
