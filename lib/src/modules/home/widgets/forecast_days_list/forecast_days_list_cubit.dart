import 'package:flutter_bloc/flutter_bloc.dart';

class ForecastDaysListCubit extends Cubit<int> {
  ForecastDaysListCubit() : super(0);
}

abstract class ForecastDaysListState {}

class ForecastDaysListStateLoading extends ForecastDaysListState {}

class ForecastDaysListStateSuccess extends ForecastDaysListState {}

class ForecastDaysListStateError extends ForecastDaysListState {
  final Exception error;
  ForecastDaysListStateError(this.error);
}
