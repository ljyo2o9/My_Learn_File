import 'package:flutter/widgets.dart';

import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/data/repository/weather_repository.dart';

class WeatherViewModel extends ChangeNotifier {
  final WeatherRepository _weatherRepository = WeatherRepository();

  WeatherViewModel() {
    _getWeatherList();
  }

  String _comment = '';
  List<Item> _weatherList = [];

  String get comment => _comment;

  List<Item> get weatherList => _weatherList;

  Future<String> _getWeather() async {
    if (weatherList.isEmpty) await _getWeatherList();
    switch (_weatherList[0].obsrValue) {
      case '0':
        return 'It\'s sun time';
      case '1':
      case '4':
      case '5':
        return 'Yes. It\'s raining';
      case '3':
      case '7':
        return 'It\'s snowing';
      case '2':
      case '6':
        return 'Sleet is falling';
      default:
        return '';
    }
  }

  Future<void> _getWeatherList() async {
    _weatherList = await _weatherRepository.getWeatherList();
    _comment = await _getWeather();
    notifyListeners();
  }
}
