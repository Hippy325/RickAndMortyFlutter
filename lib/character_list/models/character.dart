import 'package:equatable/equatable.dart';
import 'package:flutter_application_1/character_service/models/character_dto.dart';

class Character extends Equatable {
  final int id;
  final String name;
  final String species;
  final String gender;
  final String status;
  final List<String> episode;
  final String image;
  final bool isFavorite;
  final String? imageNameLocal;

  const Character({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.status,
    required this.episode,
    required this.image,
    required this.isFavorite,
    this.imageNameLocal,
  });

  factory Character.fromDto(CharacterDto dto) {
    return Character(
      id: dto.id ?? -1,
      name: dto.name ?? '',
      species: dto.species ?? '',
      gender: dto.gender ?? '',
      status: dto.status ?? '',
      episode: dto.episode ?? [],
      image: dto.image ?? '',
      isFavorite: false,
    );
  }

  @override
  List<Object?> get props => [
        id,
        name,
        species,
        gender,
        status,
        episode,
        image,
        isFavorite,
        imageNameLocal,
      ];

  Character copyWith({
    bool? isFavorite,
    String? imageNameLocal,
  }) =>
      Character(
        id: id,
        name: name,
        species: species,
        gender: gender,
        status: status,
        episode: episode,
        image: image,
        isFavorite: isFavorite ?? this.isFavorite,
        imageNameLocal: imageNameLocal ?? this.imageNameLocal,
      );

  Map<String, dynamic> toJson() => {
        'id': id,
        'name': name,
        'species': species,
        'gender': gender,
        'status': status,
        'episode': episode,
        'image': image,
        'isFavorite': isFavorite,
        'imageNameLocal': imageNameLocal,
      };

  static Character fromJson(Map<String, dynamic> json) => Character(
        id: json['id'],
        name: json['name'],
        species: json['species'],
        gender: json['gender'],
        status: json['status'],
        episode: List<String>.from(json['episode']),
        image: json['image'],
        isFavorite: json['isFavorite'],
        imageNameLocal: json['imageNameLocal'],
      );
}
