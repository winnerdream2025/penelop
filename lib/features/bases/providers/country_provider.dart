import 'dart:convert';
import 'package:get_storage/get_storage.dart';
import 'package:http/http.dart' as http;
import 'package:riverpod/legacy.dart';

class CountryNotifier extends StateNotifier<String?> {
  final GetStorage _box;
  static const String prefKey = 'selected_country';

  CountryNotifier(this._box) : super(null) {
    loadCountry();
  }

  Future<void> loadCountry() async {
    final savedCountryCode = _box.read(prefKey);

    if (savedCountryCode != null) {
      state = savedCountryCode;
    } else {
      state = await getCountryFromIP();
      if (state != null) {
        _box.write(prefKey, state);
      } else {
        _box.write(prefKey, "TG");
      }
    }
  }

  void setCountry(String countryCode) {
    state = countryCode;
    _box.write(prefKey, countryCode);
  }
}

Future<String?> getCountryFromIP() async {
  final response = await http.get(Uri.parse('https://ipinfo.io/json'));
  if (response.statusCode == 200) {
    final data = json.decode(response.body);
    return data['country'];
  } else {
    return null;
  }
}

// Provider pour le CountryNotifier
final countryProvider = StateNotifierProvider<CountryNotifier, String?>((ref) {
  final box = GetStorage();
  return CountryNotifier(box);
});
