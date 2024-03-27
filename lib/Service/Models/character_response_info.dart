
// import 'package:convert/convert.dart';

class CharacterResponseInfo {
  final int count;
  final int pages; 
  final String? next;

  const CharacterResponseInfo({required this.count, this.next, required this.pages});

  factory CharacterResponseInfo.fromJson(Map<String, dynamic> json) {
    return switch (json) {
      {
        'count': int count,
        'pages': int pages,
        'next': String? next
      } => CharacterResponseInfo(count: count, pages: pages, next: next),
      _ => throw const FormatException('Failed to load characters info.'),
    };
  }

  // factory CharacterResponseInfo.fromJson(Map<String, dynamic> json) {
  //   return CharacterResponseInfo(
  //     json['count'],
  //     json['pages'],
  //     json['next']
  //   );
  // }
}