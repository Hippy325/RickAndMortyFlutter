import 'package:flutter_application_1/character_service/models/character_dto.dart';
import 'package:flutter_application_1/character_service/models/character_info_dto.dart';

class CharacterResponseDto {
  final CharacterInfoDto? info;
  final List<CharacterDto> results;

  CharacterResponseDto({
    required this.info,
    required this.results,
  });

  factory CharacterResponseDto.fromJson(Map<String, dynamic> json) {
    return CharacterResponseDto(
      info: CharacterInfoDto.fromJson(json['info']),
      results: json['results'] != null
          ? List<CharacterDto>.from(
              json['results'].map((x) => CharacterDto.fromJson(x)))
          : [],
    );
  }
}
