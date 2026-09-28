import 'dart:convert';

import 'package:http/http.dart' as http;

Future<String?> getCountryFromIP() async {
  final response = await http.get(Uri.parse('https://ipinfo.io/json'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['country'];
  } else {
    return null;
  }
}