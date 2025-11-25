import 'dart:convert';
import 'package:flutter_application_1/character_list/models/character.dart';
import 'package:flutter_application_1/utils/shared/shared.dart';
import 'package:shared_preferences/shared_preferences.dart';

class SharedImpl extends Shared {
  static const String _key = 'characters';

  @override
  Future<List<Character>> getAllCharacters() async {
    final prefs = await SharedPreferences.getInstance();
    final jsonString = prefs.getString(_key);

    if (jsonString == null) return [];

    final List<dynamic> jsonList = json.decode(jsonString);
    return jsonList.map((e) => Character.fromJson(e)).toList();
  }

  @override
  Future<void> addCharacter(Character character) async {
    final prefs = await SharedPreferences.getInstance();
    final characters = await getAllCharacters();

    if (!characters.any((c) => c.id == character.id)) {
      characters.add(character);
    }

    final jsonList = characters.map((c) => c.toJson()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }

  @override
  Future<void> removeCharacter(int id) async {
    final prefs = await SharedPreferences.getInstance();
    final characters = await getAllCharacters();

    characters.removeWhere((c) => c.id == id);

    final jsonList = characters.map((c) => c.toJson()).toList();
    await prefs.setString(_key, json.encode(jsonList));
  }
}
