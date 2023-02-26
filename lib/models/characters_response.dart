import 'package:marvel_characters_app/models/character.dart';

class CharactersResponse {
  final int? offset;
  final int? limit;
  final int? total;
  final int? count;
  final List<Character> result;

  CharactersResponse({
    this.offset,
    this.count,
    this.limit,
    this.total,
    required this.result,
  });

  factory CharactersResponse.fromJson(Map<String, dynamic> map) {
    return CharactersResponse(
      offset: map['offset'] as int?,
      count: map['count'] as int?,
      limit: map['limit'] as int?,
      total: map['total'] as int?,
      result: List<Character>.from(
        (map['results'] as List<dynamic>).map<Character>(
          (e) => Character.fromJson(e as Map<String, dynamic>),
        ),
      ),
    );
  }
}
