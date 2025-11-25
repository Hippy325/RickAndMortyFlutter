// import 'package:convert/convert.dart';

class CharacterInfoDto {
  final int? count;
  final int? pages;
  final String? next;

  const CharacterInfoDto({
    required this.count,
    this.next,
    required this.pages,
  });

  factory CharacterInfoDto.fromJson(Map<String, dynamic> json) {
    return CharacterInfoDto(
      count: json['count'],
      pages: json['count'],
      next: json['next'],
    );
  }
}
