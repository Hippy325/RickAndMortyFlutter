
import 'dart:convert';
import 'package:flutter_application_1/Service/Models/character_response.dart';
import 'package:http/http.dart' as http;

class CharacterPageLoader {

  String? nextPageUrl = 'https://rickandmortyapi.com/api/character';
  bool isFinished = false;

  Future<CharacterResponse?> loadNextPage() async {
    if (nextPageUrl == null) {
      return null;
    }

    final Uri url = Uri.parse(nextPageUrl!);
    final http.Response response = await http.get(url);
    var responseData = jsonDecode(response.body);
    var characterResponse = CharacterResponse.fromJson(responseData);
    nextPageUrl = characterResponse.info.next;
    isFinished = characterResponse.info.next == null;
    return characterResponse;
  }
}