class ForecastDayWeatherEntity {
  DateTime date;
  String weekdayName;
  int tempMax;
  int tempMin;
  String iconUrl;

  ForecastDayWeatherEntity(
    this.date,
    this.weekdayName,
    this.tempMax,
    this.tempMin,
    this.iconUrl,
  );

  ForecastDayWeatherEntity copyWith({
    DateTime? date,
    String? weekdayName,
    int? tempMax,
    int? tempMin,
    String? iconUrl,
  }) {
    return ForecastDayWeatherEntity(
      date ?? this.date,
      weekdayName ?? this.weekdayName,
      tempMax ?? this.tempMax,
      tempMin ?? this.tempMin,
      iconUrl ?? this.iconUrl,
    );
  }
}
