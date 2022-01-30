import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:shared_preferences/shared_preferences.dart';

class Network {
  final String _url = 'https://www.bogdzonhov.mn/api';
  //if you are using android studio emulator, change localhost to 10.0.2.2

  // _getToken() async {
  //   SharedPreferences localStorage = await SharedPreferences.getInstance();
  //   token = jsonDecode(localStorage.getString('token'))['token'];
  // }

  checkData(data, apiUrl) async {
    var fullUrl = _url + apiUrl;
    return await http.post(fullUrl, body: data);
  }

  getData(data, apiUrl) async {
    var fullUrl = 'https://www.bogdzonhov.mn/out.json';
    // await _getToken();
    return await http.get(fullUrl);
  }

  forThirdApi() async {
    var fullUrl = 'https://www.bogdzonhov.mn/out.json';
    return await http.get(fullUrl);
  }
}
