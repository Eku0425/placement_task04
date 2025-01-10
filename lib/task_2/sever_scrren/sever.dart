import 'dart:convert';

import 'package:get/get.dart';
import 'package:http/http.dart' as http;

import 'package:shared_preferences/shared_preferences.dart';

import '../modal_class/modal_class.dart';

class AuthService {
  Future<Map<String, dynamic>> login(String username, String password) async {
    final url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.loginEndpoint}');
    final response = await http.post(
      url,
      body: json.encode({'username': username, 'password': password}),
      headers: {'Content-Type': 'application/json'},
    );

    if (response.statusCode == 200) {
      final userData = json.decode(response.body);
      String token = userData['accessToken'];
      await _saveToken(token);
      return json.decode(response.body);
    } else {
      throw Exception('Login failed: ${response.body}');
    }
  }

  Future<List<Map<String, dynamic>>> getAllUsers() async {
    final accessToken = await _getToken();
    final url =
        Uri.parse('${ApiConstants.baseUrl}${ApiConstants.usersEndpoint}');

    final response = await http.get(
      url,
      headers: {
        'Authorization': 'Bearer $accessToken',
        'Content-Type': 'application/json',
      },
    );

    if (response.statusCode == 200) {
      // Decode the response and return the list of users
      // final userDetails = userData['user'];
      //     await StorageHelper.saveUserDetails(userDetails);  // Save user details
      //     return userData;
      final usersData = json.decode(response.body);
      return List<Map<String, dynamic>>.from(usersData['users']);
      // await StorageHelper.saveUserDetails(userDetails);  // Save user details
    } else {
      throw Exception('Failed to load users: ${response.body}');
    }
  }

  Future<void> _saveToken(String token) async {
    final prefs = await SharedPreferences.getInstance();
    await prefs.setString('auth_token', token);
  }

  // Retrieve the saved token
  Future<String> _getToken() async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getString('auth_token') ??
        ''; // Return an empty string if no token is found
  }
}

class StorageHelper {
  static Future<void> saveUserDetails(
    List<Map<String, dynamic>> userDetails,
  ) async {
    final SharedPreferences ref = await SharedPreferences.getInstance();
    print(userDetails);
    print(
        'data of save detail +++++++++++++++++++++======================================================================');
    // final prefs = await SharedPreferences.getInstance();
    await ref.setString('userDetails', json.encode(userDetails));
    // String jsonString = jsonEncode(userList);
    // await prefs.setString('userList', json.encode(userDetails.map((u) => u.toJson()).toList()));
  }

  static Future<List<Map<String, dynamic>>?> getUserDetails() async {
    // Simulate getting data from SharedPreferences or another storage mechanism
    final ref = await SharedPreferences.getInstance();
    final userData = ref.getString('userDetails');
    if (userData != null) {
      return List<Map<String, dynamic>>.from(jsonDecode(userData));
    }
    return null;
  }

  StorageHelper() {
    getUserDetails();
  }
}
