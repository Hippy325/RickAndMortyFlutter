import 'dart:convert';

import 'package:flutter_application_1/character_service/character_service.dart';
import 'package:flutter_application_1/character_service/models/character_dto.dart';
import 'package:flutter_application_1/character_service/models/character_response_dto.dart';
import 'package:http/http.dart' as http;

class CharacterServiceImpl extends CharacterService {
  @override
  Future<CharacterDto?> load(int characterIndex) async {
    String characterURL = 'https://rickandmortyapi.com/api/character/';
    final Uri url = Uri.parse(characterURL + characterIndex.toString());
    final http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    var characterResponse = CharacterDto.fromJson(responseData);
    return characterResponse;
  }

  @override
  Future<CharacterResponseDto?> loadNextPage({String? nextPageUrl}) async {
    final Uri url =
        Uri.parse(nextPageUrl ?? 'https://rickandmortyapi.com/api/character');
    final http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    var characterResponse = CharacterResponseDto.fromJson(responseData);
    return characterResponse;
  }
}
