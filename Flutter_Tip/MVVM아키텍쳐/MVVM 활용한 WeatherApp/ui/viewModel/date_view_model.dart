import 'package:flutter/material.dart';
import 'package:weather_app/data/repository/date_repository.dart';

class DateViewModel extends ChangeNotifier {
  final WeekRepository _weekRepository = WeekRepository();
  final MonthRepository _monthRepository = MonthRepository();

  String _dayOfWeek = '';
  String _monthData = '';

  String get dayOfWeek => _dayOfWeek;

  String get monthData => _monthData;

  DateViewModel() {
    _getDayOfWeek();
    _getMonthData();
  }

  Future<void> _getDayOfWeek() async {
    _dayOfWeek = await _weekRepository.getDayOfWeek();
    notifyListeners();
  }

  Future<void> _getMonthData() async {
    _monthData = await _monthRepository.getMonthData();
    notifyListeners();
  }
}
