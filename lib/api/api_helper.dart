import 'dart:convert';
import 'package:http/http.dart';
import 'package:http/http.dart' as http;

class ApiHelper {
  Future fetchDataFromApi() async {
    String api = "https://jsonplaceholder.typicode.com/todos";

    Uri url = Uri.parse(api);
    Response response = await http.get(url);
    if (response.statusCode == 200) {
      final json = response.body;
      final List data = jsonDecode(json);
      print(data);
      return data;
    } else {
      return [];
    }
  }
}
