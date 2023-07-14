class DateHelper {
  String getAbbreviatedWeekDayName(int weekday) {
    if (weekday == 2) return 'ter.';
    if (weekday == 3) return 'qua.';
    if (weekday == 4) return 'qui.';
    if (weekday == 5) return 'sex.';
    if (weekday == 6) return 'sáb.';
    if (weekday == 7) return 'dom.';
    return 'seg.';
  }

  String getFullWeekDayName(int weekday) {
    if (weekday == 1) return 'Segunda';
    if (weekday == 2) return 'Terça';
    if (weekday == 3) return 'Quarta';
    if (weekday == 4) return 'Quinta';
    if (weekday == 5) return 'Sexta';
    if (weekday == 6) return 'Sábado';
    if (weekday == 7) return 'Domingo';
    return '';
  }
}
