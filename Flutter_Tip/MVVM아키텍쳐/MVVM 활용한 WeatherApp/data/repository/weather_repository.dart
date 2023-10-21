import 'package:weather_app/data/model/weather_model.dart';
import 'package:weather_app/data/dataSource/weather_data.dart';

class WeatherRepository {
  final WeatherData _weatherData = WeatherData();

  Future<List<Item>> getWeatherList() async {
    return _weatherData.getWeatherList();
  }
}
