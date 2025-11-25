class CharacterDto {
  final int? id;
  final String? name;
  final String? species;
  final String? gender;
  final String? status;
  final List<String>? episode;
  final String? image;

  CharacterDto({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.status,
    required this.episode,
    required this.image,
  });

  factory CharacterDto.fromJson(Map<String, dynamic> json) {
    return CharacterDto(
      id: json['id'],
      name: json['name'],
      species: json['species'],
      gender: json['gender'],
      status: json['status'],
      episode:
          json['episode'] != null ? List<String>.from(json['episode']) : null,
      image: json['image'],
    );
  }
}
