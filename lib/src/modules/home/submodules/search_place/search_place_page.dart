import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_modular/flutter_modular.dart';
import 'package:lopes_weather/src/modules/home/home_cubit.dart';
import 'package:lopes_weather/src/modules/home/submodules/search_place/search_place_cubit.dart';
import 'package:lopes_weather/src/modules/home/submodules/search_place/widgets/place_list_tile/place_list_tile.dart';
import 'package:lopes_weather/src/shared/widgets/custom_text_form_field/custom_text_form_field.dart';

class SearchPlacePage extends StatefulWidget {
  const SearchPlacePage({super.key});

  @override
  State<SearchPlacePage> createState() => _SearchPlacePageState();
}

class _SearchPlacePageState extends State<SearchPlacePage> {
  late final TextEditingController _localController;
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SearchPlaceCubit cubit = Modular.get<SearchPlaceCubit>();
  final HomeCubit homeCubit = Modular.get<HomeCubit>();
  final FocusNode _focus = FocusNode();

  @override
  void initState() {
    super.initState();
    _localController = TextEditingController();
    _focus.requestFocus();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: Container(
        padding: const EdgeInsets.fromLTRB(22, 22, 22, 0),
        width: double.infinity,
        child: Center(
          child: ConstrainedBox(
            constraints: const BoxConstraints(maxWidth: 600),
            child: SafeArea(
              child: Column(
                mainAxisSize: MainAxisSize.max,
                children: [
                  Flexible(
                    flex: 1,
                    child: Form(
                      key: _formKey,
                      child: CustomTextFormField(
                        controller: _localController,
                        suffixIcon: Icons.close,
                        prefixIcon: Icons.arrow_back,
                        onChanged: (value) {
                          if (value.isNotEmpty) {
                            cubit.placeAutoComplete(value);
                          }
                        },
                        prefixIconPressed: () => Modular.to.pop(),
                        suffixIconPressed: () {
                          setState(() {
                            _localController.text = '';
                            cubit.placesList = [];
                          });
                        },
                        color: Colors.black,
                        focusNode: _focus,
                      ),
                    ),
                  ),
                  Flexible(
                    child: BlocConsumer(
                      listener: (context, state) {
                        if (state is SearchPlaceStateSuccess) {
                          setState(() {});
                        }
                      },
                      bloc: cubit,
                      builder: (context, state) {
                        return Center(
                          child: ConstrainedBox(
                            constraints: const BoxConstraints(
                              maxHeight: 750,
                            ),
                            child: Padding(
                              padding: const EdgeInsets.only(top: 16.0),
                              child: Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  ElevatedButton(
                                    style: ElevatedButton.styleFrom(
                                      backgroundColor: Colors.grey[350],
                                      padding: const EdgeInsets.all(12),
                                      elevation: 0,
                                    ),
                                    onPressed: () {
                                      Modular.to.pop();
                                      homeCubit.getLocationWeather();
                                    },
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: const [
                                        Icon(
                                          Icons.my_location,
                                          color: Colors.black,
                                        ),
                                        SizedBox(
                                          width: 12,
                                        ),
                                        Text(
                                          'Usar localização atual',
                                          style: TextStyle(
                                            color: Colors.black,
                                            fontSize: 16,
                                          ),
                                        ),
                                      ],
                                    ),
                                  ),
                                  const SizedBox(
                                    height: 12,
                                  ),
                                  const Divider(
                                    thickness: 1,
                                  ),
                                  Expanded(
                                    child: ListView.builder(
                                      itemCount: cubit.placesList.length,
                                      itemBuilder: (context, index) {
                                        return GestureDetector(
                                          onTap: () {
                                            Modular.to.pop();
                                            homeCubit.getLocationWeather(
                                                description:
                                                    cubit.placesList[index]
                                                        ['description']);
                                          },
                                          child: PlaceListTile(
                                            name: cubit.placesList[index]
                                                ['description'],
                                          ),
                                        );
                                      },
                                    ),
                                  )
                                ],
                              ),
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
