import 'dart:async';
import 'dart:convert';

import 'package:app/entities/create_plant_dto.dart';
import 'package:app/entities/get_plant_dto.dart';
import 'package:app/environment.dart';
import 'package:app/services/i_plant_service.dart';
import 'package:http/http.dart' as http;

class PlantService implements IPlantService{

  @override
  Future<List<GetPlantDto>> getPlants() async {
    try {
      final uri = Uri.parse("${Environment.apiUrl}/plant/fetch");

      final response = await http
          .get(uri)
          .timeout(const Duration(seconds: 5), onTimeout: () {
        throw TimeoutException("A requisição demorou muito para responder");
      });

      if (response.statusCode == 200) {
        return getPlantDtoFromJson(response.body);
      } else {
        throw Exception("Erro ao buscar plantas: ${response.statusCode}");
      }
    } on TimeoutException catch (_) {
      throw Exception("A requisição expirou. Verifique sua conexão com a internet.");
    } on http.ClientException catch (e) {
      throw Exception("Erro de cliente HTTP: ${e.message}");
    } catch (e) {
      throw Exception("Erro inesperado: $e");
    }
  }

  @override
  Future<GetPlantDto> createPlant(CreatePlantDto plantDto) async{
    try {
      final uri = Uri.parse("${Environment.apiUrl}/plant/create");
      final plantJson = jsonEncode(plantDto);

      final response = await http
          .post(uri,body: plantJson, headers: {
        "Content-Type": "application/json", // Especifica que é um JSON
      },)
          .timeout(const Duration(seconds: 10), onTimeout: () {
        throw TimeoutException("A requisição demorou muito para responder");
      });

      if (response.statusCode == 201) {
        return GetPlantDto.fromJson(jsonDecode(response.body));
      } else {
        throw Exception("Erro ao criar planta: ${response.body}");
      }
    } on TimeoutException catch (_) {
      throw Exception("A requisição expirou. Verifique sua conexão com a internet.");
    } on http.ClientException catch (e) {
      throw Exception("Erro de cliente HTTP: ${e.message}");
    } catch (e) {
      throw Exception("Erro inesperado: $e");
    }
  }
}
