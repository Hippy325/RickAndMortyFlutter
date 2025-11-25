import 'package:flutter_application_1/character_service/models/character_dto.dart';
import 'package:flutter_application_1/character_service/models/character_response_dto.dart';

abstract class CharacterService {
  Future<CharacterResponseDto?> loadNextPage({String? nextPageUrl});
  Future<CharacterDto?> load(int characterIndex);
}
