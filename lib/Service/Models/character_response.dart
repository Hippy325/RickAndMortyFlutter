
import 'package:flutter_application_1/Service/Models/character.dart';
import 'package:flutter_application_1/Service/Models/character_response_info.dart';

class CharacterResponse {

  final CharacterResponseInfo info;
  final List<Character> results;

  CharacterResponse({required this.info, required this.results});

  factory CharacterResponse.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'info': Map<String, dynamic> info,
        'results': List<dynamic> results
      } => CharacterResponse(info: CharacterResponseInfo.fromJson(info), results: results.map((e) => Character.fromJson(e)).toList()),
      _ => throw  const FormatException('Failed to load characters info.'),
    };
  }

  // factory CharacterResponse.fromJson(Map<String, dynamic> json) {
  //   return CharacterResponse(
  //     json['info'], 
  //     json['results']
  //     );
  // }
}