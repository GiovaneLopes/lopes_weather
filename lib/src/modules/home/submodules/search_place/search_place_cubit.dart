import 'dart:convert';

import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';
import 'package:lopes_weather/src/shared/utils/network_utility.dart';

class SearchPlaceCubit extends Cubit<SearchPlaceState> {
  SearchPlaceCubit() : super(SearchPlaceStateLoading());

  List<dynamic> placesList = [];

  Future<void> placeAutoComplete(String query) async {
    Uri uri = Uri.https(
      'maps.googleapis.com',
      'maps/api/place/autocomplete/json',
      {
        "input": query,
        "key": dotenv.env['GOOGLE_PLACES_API_KEY'],
        "language": "pt"
      },
    );

    var response = await NetWorkUtility.fetchUrl(uri);
    if (response != null) {
      placesList = jsonDecode(response.toString())['predictions'];
      emit(SearchPlaceStateSuccess());
    }
  }
}

abstract class SearchPlaceState {}

class SearchPlaceStateLoading extends SearchPlaceState {}

class SearchPlaceStateSuccess extends SearchPlaceState {}

class SearchPlaceStateError extends SearchPlaceState {
  final Exception error;
  SearchPlaceStateError(this.error);
}
