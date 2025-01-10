import 'package:get/get.dart';
import 'package:get/get_state_manager/src/simple/get_controllers.dart';
import 'package:shared_preferences/shared_preferences.dart';

import '../sever_scrren/sever.dart';

int index = 0;
List<Map<String, dynamic>> userList = [];

class LoginController extends GetxController {
  final AuthService _authService = AuthService();
  var isLoading = false.obs;
  var loginOrLogOut = false;

  Future<void> loadDataLogin() async {
    final prefs = await SharedPreferences.getInstance();
    loginOrLogOut = prefs.getBool('loginOrLogOut') ?? false;
  }

  Future<void> screenViewLogin() async {
    loginOrLogOut = !loginOrLogOut;
    print(loginOrLogOut);
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('loginOrLogOut', loginOrLogOut);
  }

  Future<void> login(String username, String password) async {
    StorageHelper.getUserDetails();
    isLoading.value = true;
    print(userList);
    try {
      print(
          'userlist is _____________________________________+===================================================================');
      final user = await _authService.login(username, password);
      // userList.add(user);
      userList.insert(index, user);
      index++;
      print(userList);
      print(index);
      await StorageHelper.saveUserDetails(userList);
      Get.offNamed('/home');
    } catch (e) {
      Get.snackbar('Error', e.toString());
    } finally {
      isLoading.value = false;
    }
  }

  LoginController() {
    screenViewLogin();
    loadDataLogin();
  }
}
