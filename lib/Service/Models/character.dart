
class Character {
  final int id;
  final String name;
  final String species;
	final String gender;
	final String status;
	// final String location;
	final List<String> episode;
	final String image;

  Character({
    required this.id,
    required this.name,
    required this.species,
    required this.gender,
    required this.status,
    required this.episode,
    // required this.location,
    required this.image,
  });

  factory Character.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'id': int id,
        'name': String name,
        'species': String species,
        'gender': String gender,
        'status': String status,
        // 'location': String location,
        'episode': List<dynamic> episode,
        'image': String image
      } => Character(id: id, name: name, species: species, gender: gender, status: status, episode: episode.map((e) => e as String).toList(), image: image),
      _ => throw const FormatException('Failed to load characters info.'),
    };
  }

    // Character.fromJson(Map<String, dynamic> json)
    // : id = json['id'] as int,
    //   name = json['name'] as String,
    //   species = json['species'] as String,
    //   gender = json['gender'] as String,
    //   status = json['status'] as String,
    //   location = (json['location'] as Map<String, dynamic>)['name'] as String,
    //   episode = json['episode'] as List<String>,
    //   image = json['image'] as String;
}