import 'package:marvel_characters_app/models/comic.dart';

class CharacterDetails {
  final int id;
  final String name;
  final String? thumbnail;
  final String? description;
  final List<Comic> comics;

  CharacterDetails({
    required this.id,
    required this.name,
    this.thumbnail,
    this.description,
    required this.comics,
  });

  factory CharacterDetails.fromJson(Map<String, dynamic> map) {
    final details = map['results'][0];
    return CharacterDetails(
      id: details['id'] as int,
      name: details['name'] as String,
      description: details['description'] as String?,
      thumbnail:
          "${details['thumbnail']['path']}.${details['thumbnail']['extension']}",
      comics: List<Comic>.from(
        (details['comics']['items'] as List<dynamic>).map<Comic>(
          (e) => Comic.fromJson(e),
        ),
      ),
    );
  }
}
