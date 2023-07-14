class LocationNotEnabledException implements Exception {
  final String message;
  LocationNotEnabledException({
    required this.message,
  });
}

class LocationNotAllowedException implements Exception {
  final String message;
  LocationNotAllowedException({
    required this.message,
  });
}
