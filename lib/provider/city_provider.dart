import 'package:flutter/foundation.dart';

class CityProvider with ChangeNotifier {
  String _cityName = "My City";

  String get cityName => _cityName;

  void updateCityName(String newName) {
    _cityName = newName;
    notifyListeners();
  }
}
