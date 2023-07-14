import 'package:auto_size_text/auto_size_text.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lopes_weather/src/modules/home/home_cubit.dart';

class ForecastDaysListWidget extends StatefulWidget {
  const ForecastDaysListWidget({super.key});

  @override
  State<ForecastDaysListWidget> createState() => _ForecastDaysListWidgetState();
}

class _ForecastDaysListWidgetState extends State<ForecastDaysListWidget> {
  final HomeCubit cubit = Modular.get<HomeCubit>();
  @override
  Widget build(BuildContext context) {
    return Center(
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          const AutoSizeText(
            'Próximos dias',
            style: TextStyle(
              fontWeight: FontWeight.w500,
              fontSize: 22,
            ),
          ),
          const SizedBox(
            height: 8,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: cubit.forecast!.map((dayWeather) {
              return Padding(
                padding: const EdgeInsets.only(left: 8.0),
                child: Column(
                  children: [
                    Container(
                      height: 100,
                      width: 55,
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius: BorderRadius.circular(8),
                        border: Border.all(color: Colors.grey),
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          AutoSizeText(
                            dayWeather.weekdayName,
                            style: const TextStyle(fontWeight: FontWeight.w500),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          Container(
                            height: 40,
                            width: 40,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(100),
                            ),
                            child: CachedNetworkImage(
                              imageUrl:
                                  'https://openweathermap.org/img/wn/${dayWeather.iconUrl}@2x.png',
                              placeholder: ((context, url) => const Center(
                                    child: CircularProgressIndicator(
                                      color: Colors.black,
                                    ),
                                  )),
                              errorWidget: (context, url, error) =>
                                  const Icon(Icons.close),
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(
                            height: 8,
                          ),
                          RichText(
                            text: TextSpan(
                              children: [
                                TextSpan(
                                  text: '${dayWeather.tempMax.toString()}/',
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.black,
                                  ),
                                ),
                                TextSpan(
                                  text: dayWeather.tempMin.toString(),
                                  style: const TextStyle(
                                    fontWeight: FontWeight.w500,
                                    color: Colors.grey,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
              );
            }).toList(),
          ),
        ],
      ),
    );
  }
}
