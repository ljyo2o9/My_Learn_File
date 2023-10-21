import 'package:weather_app/data/dataSource/date_data.dart';

class WeekRepository {
  final WeekData _weekData = WeekData();

  Future<String> getDayOfWeek() async {
    return _weekData.getWeekData();
  }
}

class MonthRepository {
  final MonthData _monthData = MonthData();

  Future<String> getMonthData() async {
    return _monthData.getMonthData();
  }
}
