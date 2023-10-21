class WeekData {
  Future<String> getWeekData() async {
    String dayOfWeek = await _getDayOfWeek(DateTime.now().weekday);

    return dayOfWeek;
  }

  Future<String> _getDayOfWeek(int weekday) async {
    switch (weekday) {
      case DateTime.monday:
        return 'Monday';
      case DateTime.tuesday:
        return 'Tuesday';
      case DateTime.wednesday:
        return 'Wednesday';
      case DateTime.thursday:
        return 'Thursday';
      case DateTime.friday:
        return 'Friday';
      case DateTime.saturday:
        return 'Saturday';
      case DateTime.sunday:
        return 'Sunday';
      default:
        return '';
    }
  }
}

class MonthData {
  Future<String> getMonthData() async {
    String month = await _getMonth(DateTime.now().month);

    return month;
  }

  Future<String> _getMonth(int monthData) async {
    switch (monthData) {
      case 1:
        return 'January';
      case 2:
        return 'February';
      case 3:
        return 'March';
      case 4:
        return 'April';
      case 5:
        return 'May';
      case 6:
        return 'June';
      case 7:
        return 'July';
      case 8:
        return 'August';
      case 9:
        return 'September';
      case 10:
        return 'October';
      case 11:
        return 'November';
      case 12:
        return 'December';
      default:
        return '';
    }
  }
}
