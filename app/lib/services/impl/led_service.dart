import 'dart:convert';

import 'package:app/environment.dart';
import 'package:app/services/i_led_service.dart';
import 'package:http/http.dart';

class LedService implements ILedService {
  @override
  Future<bool> getLedState() async {
    try {
      var response = await get(Uri.parse("${Environment.apiUrl}/led/fetch"));

      if (response.statusCode == 200) {
        var responseJson = jsonDecode(response.body);
        return responseJson["status"] == "On" ? true : false;
      }
      throw Exception("Falha ao buscar plantas: ${response.body}");
    } catch (e) {
      throw Exception("Falha ao obter estado dos leds: ${e.toString()}");
    }
  }

  @override
  Future<void> toggleLed() async {
    try {
      var response = await post(Uri.parse("${Environment.apiUrl}/led/toggle"));

      if (response.statusCode != 200) {
        throw Exception("Falha ao alterar estado dos leds: ${response.body}");
      }
    } catch (e) {
      throw Exception("Falha ao alterar estado dos leds: ${e.toString()}");
    }
  }
}
