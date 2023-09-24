import 'package:shared_preferences/shared_preferences.dart';

class TodoDataSource {
  SharedPreferences? _pref;

  Future<void> init() async {
    _pref = await SharedPreferences.getInstance();
  }

  Future<List<String>> getTodoList() async {
    if (_pref == null) {
      await init();
    }

    final response = _pref!.getStringList('mainList') ?? [];
    return response;
  }
}
