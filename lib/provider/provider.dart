import 'package:flutter/cupertino.dart';
import 'package:placement_task04/modal_class/modal_class.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../api/api_helper.dart';

class TodoProvider with ChangeNotifier {
  List<ModalClass> todos = [];
  bool isGrid = false;
  bool isDarkTheme = false;
  ApiHelper apiHelper = ApiHelper();

  Future<void> fetchTodos() async {
    List pro = await apiHelper.fetchDataFromApi();
    todos = pro.map((data) => ModalClass.fromJson(data)).toList();
    notifyListeners();
  }

  Future<void> loadData() async {
    final prefs = await SharedPreferences.getInstance();
    isGrid = prefs.getBool('isGrid') ?? false;
    isDarkTheme = prefs.getBool('isDarkTheme') ?? false;
    notifyListeners();
  }

  Future<void> screenView() async {
    isGrid = !isGrid;
    print(isGrid);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isGrid', isGrid);
    notifyListeners();
  }

  Future<void> screenTheme() async {
    isDarkTheme = !isDarkTheme;
    print(isDarkTheme);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('isDarkTheme', isDarkTheme);
    notifyListeners();
  }

  TodoProvider() {
    loadData();
    fetchTodos();
  }
}
