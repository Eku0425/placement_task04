// import 'package:flutter/material.dart';
// import 'package:placement_task04/provider/provider.dart';
// import 'package:placement_task04/screen/todo_sreen.dart';
// import 'package:provider/provider.dart';
// import 'package:shared_preferences/shared_preferences.dart';
//
// bool isDark = false;
//
// Future<void> main() async {
//   WidgetsFlutterBinding.ensureInitialized();
//   SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
//   sharedPreferences.getBool('isDarkTheme') ?? false;
//
//   runApp(
//     MultiProvider(
//       providers: [
//         ChangeNotifierProvider(
//           create: (context) => TodoProvider(),
//         ),
//       ],
//       child: const MyApp(),
//     ),
//   );
// }
//
// class MyApp extends StatelessWidget {
//   const MyApp({super.key});
//
//   @override
//   Widget build(BuildContext context) {
//     final provider = Provider.of<TodoProvider>(context);
//     return MaterialApp(
//       themeMode: provider.isDarkTheme ? ThemeMode.dark : ThemeMode.light,
//       theme: ThemeData.light(),
//       darkTheme: ThemeData.dark(),
//       debugShowCheckedModeBanner: false,
//       home: const TodoScreen(),
//     );
//   }
// }

import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:flutter/material.dart';
import 'package:placement_task04/task_2/api_service/api.dart';
import 'package:placement_task04/task_2/screens/deatils.dart';
import 'package:placement_task04/task_2/screens/home_page.dart';
import 'package:placement_task04/task_2/screens/home_page1.dart';
import 'package:placement_task04/task_2/screens/login_page.dart';
import 'package:placement_task04/task_2/sever_scrren/sever.dart';
import 'package:shared_preferences/shared_preferences.dart';

// void main() {
//   runApp(MyApp());
//}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      // title: 'Login System App',
      // theme: ThemeData(primarySwatch: Colors.blue),
      // home: LoginScreen(),
    );
  }
}

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  final userDetails = await StorageHelper.getUserDetails();
  SharedPreferences sharedPreferences = await SharedPreferences.getInstance();
  sharedPreferences.getBool('loginOrLogOut') ?? false;
  var con = Get.put(LoginController());
  runApp(
    GetMaterialApp(
      initialRoute:
          userDetails == null || con.loginOrLogOut != true ? '/login' : '/home',
      getPages: [
        GetPage(name: '/login', page: () => LoginScreen()),
        GetPage(name: '/home', page: () => HomeScreenData()),
        GetPage(name: '/logOutData', page: () => LogoutUser()),
        GetPage(name: '/details', page: () => DetailsScreen()),
      ],
    ),
  );
}
