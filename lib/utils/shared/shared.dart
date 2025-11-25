import 'package:flutter_application_1/character_list/models/character.dart';

abstract class Shared {
  Future<List<Character>> getAllCharacters();

  Future<void> addCharacter(Character character);

  Future<void> removeCharacter(int id);
}
