import 'dart:convert';
import 'package:flutter_application_1/Service/Models/character.dart';
import 'package:http/http.dart' as http;

class CharacterLoader {

  String characterURL = 'https://rickandmortyapi.com/api/character/';

  Future<Character?> load(int characterIndex) async {
    final Uri url = Uri.parse(characterURL + characterIndex.toString());
    final http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    var characterResponse = Character.fromJson(responseData);
    return characterResponse;
  }
}